<script>
    $(document).ready(function() {
        /* Fill all tooltips with content */
        elements = $("[data-tooltip-content]");
        elements.each(function(index) {
          classToAttach = "." + $(this).attr("data-tooltip-content");
          $(classToAttach).attr("title", $(this).text())
        });
        /* Bind tooltip to elements */
        $(".tooltipster").tooltipster({theme: "tooltipster-borderless"});
        
        /* Count words and estimate reading time */
        
        function wordsToRead(element_class) {
            var txt, count;
            txt = $(element_class).text();
            count = txt.split( /\s+/ ).filter(function(n){ return n !== "" }).length;
            return count;
        }
        
        function readingTime(num_words) {
            return Math.round(num_words / 150);
        }
        
        $("#reading-time").text("Reading time: " + readingTime(wordsToRead('.toc-content') - wordsToRead('.logobar') - wordsToRead('.panel-group') - wordsToRead('.google-analytics') - wordsToRead('.comments')) + " minutes");
        
        $(".toc-content img").each(function (i, el) {
            $(el).attr("id", "plot" + i);
        })
    });
</script>