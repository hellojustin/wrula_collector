desc "Builds and uglifies wrula javascript file."
task :require_js do
  system 'r.js -o config/almond_config.js optimize=none'
end
