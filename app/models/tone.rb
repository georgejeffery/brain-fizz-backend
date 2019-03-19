require "json"
require "ibm_watson/tone_analyzer_v3"
include IBMWatson




def find_tone(text_to_check)

  tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
  version: "2017-09-21",
  iam_apikey: ENV['IBM_AUTH'],
  url: ENV['IBM_URL'],
)
  tone = tone_analyzer.tone(
    tone_input: {text: text_to_check},
    content_type: "application/json",
    sentences: false
  )
  tone.result["document_tone"]["tones"]
end