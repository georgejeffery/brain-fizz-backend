require "json"
require "ibm_watson/tone_analyzer_v3"
include IBMWatson

tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
  version: "2017-09-21",
  iam_apikey: ENV['IBM_AUTH'],
  url: ENV['IBM_URL'],
)

text = "Team, I know that times are tough! Product sales have been disappointing for the past three quarters. We have a competitive product, but we need to do a better job of selling it!"

tone = tone_analyzer.tone(
  tone_input: {text: text},
  content_type: "application/json",
  sentences: false
)

testoutput =  tone.result

puts testoutput["document_tone"]["tones"]

