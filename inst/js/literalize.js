<!-- knitLiteral support to left-align block -->
<script>
  window.jQuery || document.write('<script src="http://code.jquery.com/jquery-latest.min.js"><\/script>')
</script>

<script defer src="https://rawgithub.com/cowboy/jquery-replacetext/master/jquery.ba-replacetext.min.js"></script>

<script defer>
  $(document).ready(function() {
    $('.r').replaceText(/^\s{4}/mg, "", true)
  } );
</script>
