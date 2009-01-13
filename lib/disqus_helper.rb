module DisqusHelpers
  def comment_thread
    %{
      <div id="disqus_thread"></div>
      <script type="text/javascript" src="http://disqus.com/forums/budapest-rb/embed.js"></script>
      <noscript><a href="http://budapest-rb.disqus.com/?url=ref">Kommentek megtekintése.</a></noscript>
    }
  end

  def comment_counter
    %{
<!-- counting comments with disqus -->
<script type="text/javascript">
//<![CDATA[
(function() {
  var links = document.getElementsByTagName('a');
  var query = '?';
  for (var i = 0; i < links.length; i++) {
    if (links[i].href.indexOf('#disqus_thread') >= 0) {
      query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
    }
  }
  document.write('<script type="text/javascript" src="http://disqus.com/forums/budapest-rb/get_num_replies.js' +        query + '"></' + 'script>');
})();
//]]>
</script>
    }
  end

  def user_voice_widget
    %{<script src="http://bprb.uservoice.com/pages/general/widgets/tab.js?alignment=right&amp;color=FFFFFF" type="text/javascript"></script>}
  end

  def user_voice_top_ideas
    %{<script src="http://bprb.uservoice.com/pages/general/widgets/top3.js" type="text/javascript"></script>}
  end
end

Webby::Helpers.register(DisqusHelpers)
