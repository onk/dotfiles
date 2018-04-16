#!/bin/sh

gem list > /tmp/before_gems.txt

gem uninstall -aIx

gem install bundler
gem install pry pry-doc
gem install benchmark-ips

gem list > /tmp/current_gems.txt
