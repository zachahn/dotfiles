let g:projectionist_heuristics = {
  \   "*.gemspec": {
  \     "lib/*.rb": {
  \       "alternate": ["test/{}_test.rb", "spec/{}_spec.rb"],
  \     },
  \     "test/*_test.rb": {
  \       "alternate": "lib/{}.rb",
  \     },
  \     "spec/*_spec.rb": {
  \       "alternate": "lib/{}.rb",
  \     },
  \   },
  \ }

let g:rails_projections = {
  \  "app/controllers/*_controller.rb": {
  \    "test": [
  \      "spec/requests/{}_spec.rb",
  \      "spec/requests/{}_request_spec.rb",
  \      "spec/controllers/{}_controller_spec.rb",
  \      "test/controllers/{}_controller_test.rb"
  \    ],
  \    "alternate": [
  \      "spec/requests/{}_spec.rb",
  \      "spec/requests/{}_request_spec.rb",
  \      "spec/controllers/{}_controller_spec.rb",
  \      "test/controllers/{}_controller_test.rb"
  \    ],
  \  },
  \  "spec/requests/*_request_spec.rb": {
  \    "command": "request",
  \    "alternate": "app/controllers/{}_controller.rb",
  \    "template": [
  \      "require \"rails_helper\"",
  \      "",
  \      "RSpec.describe {camelcase|capitalize|colons}Controller, type: :request do",
  \      "end"
  \    ]
  \   },
  \  "spec/requests/*_spec.rb": {
  \    "command": "request",
  \    "alternate": "app/controllers/{}_controller.rb",
  \    "template": [
  \      "require \"rails_helper\"",
  \      "",
  \      "RSpec.describe {camelcase|capitalize|colons}Controller, type: :request do",
  \      "end"
  \    ]
  \   },
  \  "app/workers/*.rb": {
  \    "template": [
  \      "class {camelcase|capitalize|colons}",
  \      "  include Sidekiq::Worker",
  \      "",
  \      "  def perform",
  \      "  end",
  \      "end",
  \    ]
  \  },
  \  "spec/workers/*_spec.rb": {
  \    "template": [
  \      "require \"rails_helper\"",
  \      "",
  \      "RSpec.describe {camelcase|capitalize|colons} do",
  \      "  let(:instance) {open} described_class.new {close}",
  \      "",
  \      "  describe \"#perform\" do",
  \      "  end",
  \      "end",
  \    ]
  \  },
\ }
