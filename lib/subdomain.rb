class Subdomain
  def self.matches?(request)
    case request.subdomain
      when 'www', '', nil
        false
      else
        Account.exists?(subdomain: request.subdomain)
    end
  end
end