module Jekyll
  class ColorPageGenerator < Generator
    safe true
    priority :normal

    def generate(site)
      # Collect all unique colors from posts
      all_colors = Set.new
      
      site.posts.docs.each do |post|
        if post.data['colors']
          post.data['colors'].each do |color|
            all_colors.add(color)
          end
        end
      end

      # Generate a page for each color
      all_colors.each do |color|
        site.pages << ColorPage.new(site, site.source, color)
      end
    end
  end

  class ColorPage < Page
    def initialize(site, base, color)
      @site = site
      @base = base
      @dir = 'color'
      @name = "#{color}.html"

      self.process(@name)
      
      # Use the color.html layout we created
      self.read_yaml(File.join(base, '_layouts'), 'color.html')
      
      # Set page data
      self.data['color'] = color
      self.data['title'] = "Color ##{color}"
      self.data['permalink'] = "/color/#{color}/"
    end
  end
end