class String
  # undent
  def ~
    margin =  scan(/^ +/).map(&:size).min
    gsub( /^ {#{margin}}/, '')
  end
end
