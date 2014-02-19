require 'prawn'

def draw_sprint(pdf, n)
  pdf.font_size(64) { pdf.text("Sprint #{n}", :align => :center, :valign => :center) }
end

def draw_week(pdf, start)
  finish = start + 13
  week = start.cweek
  pdf.font_size(48) do
    pdf.text("Week #{week}-#{week+1}\n#{start.strftime('%-d %b')} - #{finish.strftime('%-d %b')}", :align => :center, :valign => :center)
  end
end

def draw_year(pdf, start)
  pdf.font_size(56) do
    pdf.text(start.strftime('%Y'), :align => :center, :valign => :center)
  end
end

raise "Usage #{__FILE__} 20140108" if ARGV.length != 1

Prawn::Document.generate('paper.pdf', :page_size => 'A4', :page_layout => :landscape) do |pdf|
  date = Date.parse(ARGV[0])
  (0..13).each do |n|
    start = date + (n * 28)
    pdf.define_grid(:columns => 2, :rows => 3, :gutter => 0)

    pdf.stroke do
      pdf.move_to pdf.bounds.width / 2, 0
      pdf.line_to pdf.bounds.width / 2, pdf.bounds.height
    end

    #pdf.grid.show_all

    pdf.grid(0, 0).bounding_box do
      draw_sprint(pdf, n + 1)
    end
    pdf.grid(1, 0).bounding_box do
      draw_week(pdf, start)
    end
    pdf.grid(2, 0).bounding_box do
      draw_year(pdf, start)
    end

    pdf.grid(0, 1).bounding_box do
      draw_sprint(pdf, n + 2)
    end
    pdf.grid(1, 1).bounding_box do
      draw_week(pdf, start + 14)
    end
    pdf.grid(2, 1).bounding_box do
      draw_year(pdf, start + 14)
    end


    pdf.start_new_page
  end
end

