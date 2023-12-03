#!/bin/zsh

echo -e 'deps and their versions in gemspec\n'
cat *.gemspec | ack -o '(?<=dependency).*(?<=[<>=]\s)(?>\d+\.?\d+)' | tr -d "',><=~"

echo -e 'Deps and their version on RubyGems\n\n'
cat *.gemspec | ack -o '(?<=dependency).*(?<=[<>=]\s)(?>\d+\.?\d+)' | tr -d "',><=~" | awk '{ print $1 }' | xargs gem info -r | ack '\(\d+\.\d+\.\d+\)'

echo -e 'gemspec and current remote versions side-by-side\n\n'
paste <(cat $(ls | ack gemspec) | ack -o '(?<=dependency).*(?<=[<>=]\s)(?>\d+\.?\d+)' | tr -d "',><=~") <(cat $(ls | ack gemspec) | ack -o '(?<=dependency).*(?<=[<>=]\s)(?>\d+\.?\d+)' | tr -d "',><=~" | awk '{ print $1 }' | xargs gem info -r | ack -o '(?<=\()(\d+\.\d+\.\d+)(?!>\))')
