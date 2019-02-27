module Admin
  class DashboardController < BaseController
    skip_load_and_authorize_resource

    def index
      @daemon_statuses = Global.daemon_statuses
      @currencies_summary = Currency.all.map(&:summary)
      @register_count = Member.count
      @turnover = []
      date = DateTime.now
      for i in 1..7
        btc = AccountVersion.where(currency: 2, reason: 110, created_at: date.strftime("%Y-%m-%d 00:00:00")...date.strftime("%Y-%m-%d 23:59:59")).sum("500.0*fee")
        ltc = AccountVersion.where(currency: 4, reason: 110, created_at: date.strftime("%Y-%m-%d 00:00:00")...date.strftime("%Y-%m-%d 23:59:59")).sum("500.0*fee")
        doge = AccountVersion.where(currency: 3, reason: 110, created_at: date.strftime("%Y-%m-%d 00:00:00")...date.strftime("%Y-%m-%d 23:59:59")).sum("500.0*fee")
        spero = AccountVersion.where(currency: 5, reason: 110, created_at: date.strftime("%Y-%m-%d 00:00:00")...date.strftime("%Y-%m-%d 23:59:59")).sum("500.0*fee")
        mxt = AccountVersion.where(currency: 6, reason: 110, created_at: date.strftime("%Y-%m-%d 00:00:00")...date.strftime("%Y-%m-%d 23:59:59")).sum("500.0*fee")
        @turnover.push ( {:date => date.strftime("%Y-%m-%d"), :btc => btc, :ltc => ltc, :doge => doge, :spero => spero, :mxt => mxt} )
        date = date.ago(60*60*24)
      end
      #@turnover = { :date => date.strftime("%Y-%m-%d"), :btc => btc, :ltc => ltc, :doge => doge, :spero => spero, mxt => mxt}
    end
  end
end
