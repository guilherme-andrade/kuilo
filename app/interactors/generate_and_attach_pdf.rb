class GenerateAndAttachPdf < ApplicationInteractor
  delegate :template, :locals, :record, :attachment_name, :filename, :layout, to: :context

  def call
    generate_and_attach_pdf
  end

  def generate_and_attach_pdf
    tmp_file = generate_pdf_file
    record.send(attachment_name).attach(io: tmp_file, filename: filename)
    File.delete(tmp_file)
  end

  def generate_pdf_file
    tmp_file_name = SecureRandom.hex(10) + '.pdf'
    tmp_file_path = Rails.root.join('tmp', tmp_file_name)

    File.open(tmp_file_path, 'wb') { |file| file.write(generate_pdf) }
    File.open(tmp_file_path)
  end

  def generate_pdf
    Grover.new(absolute_html, format: format).to_pdf
  end

  def absolute_html
    Grover::HTMLPreprocessor.process relative_html, ENV['APP_BASE_URL'], 'http'
  end

  def relative_html
    ApplicationController.new.render_to_string(
      template: template,
      layout: layout,
      locals: locals
    )
  end

  def format
    context.format || 'A4'
  end
end
