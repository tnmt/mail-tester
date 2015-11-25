#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'mail'
require 'yaml'
require 'optparse'

$options = {}
OptionParser.new do |opt|
  $options[:port] = 587
  $options[:auth] = "cram_md5"

  opt.on("-a", "--auth-type=AUTH", "Authentication Type. plain cram_md5 (default: #{$options[:auth]})") do |v|
    $options[:auth] = v
  end

  opt.on("-d", "--domain=DOMAIN", "AUTH DOMAIN") do |v|
    $options[:domain] = v
  end

  opt.on("-f", "--from=FROM", "FROM ADDRESS, like sender@smtp.foobar.com") do |v|
    $options[:from] = v
  end

  opt.on("-p", "--port=PORT", "PORT Number. 25 587 (default: #{$options[:port]})") do |v|
    $options[:port] = v
  end

  opt.on("-P", "--password=PASSWORD", "AUTH Password") do |v|
    $options[:password] = v
  end

  opt.on("-s", "--server=SMTP_SERVER", "STMP Server, like smtp.foobar.com") do |v|
    $options[:server] = v
  end

  opt.on("-t", "--to=TO", "TO ADDRESS, like sender@smtp.foobar.com") do |v|
    $options[:mailto] = v
  end

end.parse!

def main()
  mail = Mail.new do
    from     $options[:from]
    to       $options[:mailto]
    subject  "test from #{$options[:server]}"
    body     "test from #{$options[:server]}"
  end

  mail.delivery_method :smtp,
    :address              => $options[:server],
    :port                 => $options[:port],
    :domain               => $options[:domain],
    :user_name            => $options[:from],
    :password             => $options[:password],
    :authentication       => $options[:auth],
    :enable_starttls_auto => true,
    :ssl                  => nil,
    :tls                  => nil,
    :openssl_verify_mode  => nil

  mail.deliver!
end

main
