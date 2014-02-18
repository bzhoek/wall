require 'prawn'

Prawn::Document.generate('pages.pdf', :page_size => 'A4', :page_layout => :landscape) do |pdf|
  date = Date.new(2014, 1, 8)
  (0..26).each do |n|
    pdf.define_grid(:columns => 2, :rows => 3, :gutter => 0)
    #pdf.grid.show_all
    puts pdf.bounds.width
    pdf.stroke do
      pdf.move_to pdf.bounds.width / 2, 0
      pdf.line_to pdf.bounds.width / 2, pdf.bounds.height
    end
    start = date + (n * 14)
    send = date + (n * 14) + 13
    week = start.cweek
    pdf.text("Week #{week}-#{week+1}")
    pdf.text("#{start.to_s} - #{send.to_s}")

  end
end