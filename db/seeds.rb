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

[
  { code: 'markdown' },
  { code: 'erb' },
].each do |f|
  TemplateFormat.find_or_create_by_code(f)
end
