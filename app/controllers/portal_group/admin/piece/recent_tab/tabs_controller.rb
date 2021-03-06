# encoding: utf-8
class PortalGroup::Admin::Piece::RecentTab::TabsController < Cms::Controller::Admin::Base
  include Sys::Controller::Scaffold::Base
  
  def pre_dispatch
    return error_auth unless @piece = Cms::Piece.find(params[:piece])
    return error_auth unless @piece.editable?
    return error_auth unless @content = @piece.content
    #default_url_options[:piece] = @piece
  end
  
  def index
    @items = PortalGroup::Piece::RecentTabXml.find(:all, @piece, :order => :sort_no)
    _index @items
  end
  
  def show
    @item = PortalGroup::Piece::RecentTabXml.find(params[:id], @piece)
    return error_auth unless @item
    _show @item
  end

  def new
    @item = PortalGroup::Piece::RecentTabXml.new(@piece, {
      :sort_no => 0
    })
  end
  
  def create
    @item = PortalGroup::Piece::RecentTabXml.new(@piece, params[:item])
    _create @item
  end
  
  def update
    @item = PortalGroup::Piece::RecentTabXml.find(params[:id], @piece)
    return error_auth unless @item
    @item.attributes = params[:item]
    _update @item
  end
  
  def destroy
    @item = PortalGroup::Piece::RecentTabXml.find(params[:id], @piece)
    _destroy @item
  end
end
