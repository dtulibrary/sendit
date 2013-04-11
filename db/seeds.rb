# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
[
  { code: 'email-html' },
  { code: 'email-text' },
#  { code: 'text-sms' },
#  { code: 'text-mms' },
#  { code: 'msg-facebook' }
#  { code: 'msg-twitter' }
].each do |t|
  TemplateType.find_or_create_by_code(t)
end

[
  { code: 'en' },
].each do |l|
  TemplateLocale.find_or_create_by_code(l)
end

# These formats are always available
formats = [
  { code: 'erb' },
  { code: 'html' },
  { code: 'str' },
  { code: 'plain' },
]

# These formats are only available if a certain gem is available
# So we try to load the gem. If success add the given code, otherwise do
# nothing.
# Some formats may be available through several gems.
# And some gems may support several formats.
checks = [
  { gem: 'asciidoctor',   code: 'ad' },
  { gem: 'bluecloth',     code: 'markdown' },
  { gem: 'builder',       code: 'builder' },
  { gem: 'coffee_script', code: 'coffee' },
  { gem: 'creole',        code: 'creole' },
  { gem: 'creole',        code: 'wiki' },
  { gem: 'csv',           code: 'rcsv' },
  { gem: 'erubis',        code: 'erubis' },
  { gem: 'etanni',        code: 'etn' },
  { gem: 'haml',          code: 'haml' },
  { gem: 'kramdown',      code: 'markdown' },
  { gem: 'less',          code: 'less' },
  { gem: 'liquid',        code: 'liquid' },
  { gem: 'markaby',       code: 'mab' },
  { gem: 'maruku',        code: 'markdown' },
  { gem: 'nokogiri',      code: 'nokogiri' },
  { gem: 'radius',        code: 'radius' },
  { gem: 'rdiscount',     code: 'markdown' },
  { gem: 'rdoc',          code: 'rdoc' },
  { gem: 'redcarpet',     code: 'redcarpet' },
  { gem: 'redcloth',      code: 'textile' },
  { gem: 'sass',          code: 'sass' },
  { gem: 'wikicloth',     code: 'mediawiki' },
  { gem: 'wikicloth',     code: 'wiki' },
  { gem: 'yajl',          code: 'yajl' },
  { gem: 'slim',          code: 'slim' },
]
checks.each do |check|
  begin
    require check[:gem]
    formats << { code: check[:code] }
  rescue LoadError => boom
  end
end

formats.uniq.each do |f|
  TemplateFormat.find_or_create_by_code(f)
end
