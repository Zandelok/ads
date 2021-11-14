set :chronic_options, hours24: true

every :sunday, at: '23:59' do
  rake 'archivating:archive'
end

every :monday, at: '01:00' do
  rake 'publishing:publish'
end
