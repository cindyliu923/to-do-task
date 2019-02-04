module Features
  module DateTimeSelectHelpers

    def select_date_and_time(date, options = {})
      field = options[:from]
      select I18n.l(date, format: '%Y'),  :from => "#{field}_1i" #year
      select I18n.l(date, format: '%B'),  :from => "#{field}_2i" #month
      select I18n.l(date, format: '%-d'), :from => "#{field}_3i" #day
      select I18n.l(date, format: '%H'),  :from => "#{field}_4i" #hour
      select I18n.l(date, format: '%M'),  :from => "#{field}_5i" #minute
    end

  end
end
