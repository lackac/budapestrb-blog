module VariousHelpers
  def sytlesheet_link path, media = 'screen, projection'
    path = '/' + path if path[0] != ?/
    path = '/css' + path unless path =~ /^\/css/
    path += '.css' unless path =~ /\.css$/
    mtime = File.mtime(File.join(File.dirname(__FILE__), '..', 'content', path)).to_i
    %{<link rel="stylesheet" href="#{path}?#{mtime}" type="text/css" media="#{media}" />}
  end

  def flickr_slideshow url
    %{
<div class="embed flickr-slideshow">
  <object type="text/html" data="#{url}" width="400" height="300"></object>
</div>
    }
  end

  def google_video docid
    %{
<div class="embed google-video">
  <object height="326" width="400" type="application/x-shockwave-flash"
          data="http://video.google.com/googleplayer.swf?docid=#{docid}&fs=true">
    <param name="allowScriptAccess" value="always"/>
    <param name="allowFullScreen" value="true"/>
    <param name="wmode" value="transparent"/>
  </object>
</div>
    }
  end
end

Webby::Helpers.register(VariousHelpers)
