# encoding: utf-8
class Cms::Admin::Tool::ConvertSettingsController < Cms::Controller::Admin::Base
  include Sys::Controller::Scaffold::Base

  def pre_dispatch
    return error_auth unless Core.user.root?
    @item = Tool::ConvertSetting.new(params[:item])
    if @item.site_url.present? && Tool::ConvertSetting.find_by_site_url(@item.site_url).present?
      @item = Tool::ConvertSetting.find_by_site_url(@item.site_url)
    end
    @items = Tool::ConvertSetting.order('created_at desc').paginate(page: params[:page], per_page: 10)
  end

  def index
  end

  def show
    @item = Tool::ConvertSetting.find(params[:id])
  end

  def create
    if @item.new_record?
      if @item.save
        flash[:notice] = "登録処理が完了しました。（#{I18n.l Time.now}）"
        redirect_to cms_tool_convert_settings_path("item[site_url]" => @item.site_url)
      else
        flash.now[:alert] = '登録処理に失敗しました。'
      end
    else
      if @item.update_attributes(params[:item])
        flash[:notice] = "更新処理が完了しました。（#{I18n.l Time.now}）"
        redirect_to cms_tool_convert_settings_path("item[site_url]" => @item.site_url) 
      else
        flash.now[:alert] = '更新処理に失敗しました。'
      end
    end
  end

  def destroy
    @item = Tool::ConvertSetting.find(params[:id])
    _destroy @item
  end
end