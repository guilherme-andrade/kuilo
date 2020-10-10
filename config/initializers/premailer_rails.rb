Premailer::Rails.config.merge!(
  remove_ids: true,
  input_encoding: 'UTF-8',
  generate_text_part: true,
  strategies: [:filesystem, :asset_pipeline, :network]
)
