<script>
$(document).ready(function(){ 

    /* Calculate readability for each file */
    function wordsToRead(txt) {
        var count;
        count = txt.split( /\s+/ ).filter(function(n){ return n !== "" }).length;
        return count;
    }
    
    function readingTime(num_words) {
        return Math.round(num_words / 150);
    }
    
    // For each link
    $(".finding a").each(function(el) {
        
        // Get the link path
        var linkElement = $(this);
        var path = linkElement.attr('href'); 
        
        // Check if it's html
        if (path.toLowerCase().indexOf("html") >= 0) {
            // Get it's content
            $.get(path, function(data) {
                var d = $(data); // Convert to jQuery object
                
                // Calculate total number of words
                var totalWords = wordsToRead(d.find('.toc-content').text()) - wordsToRead(d.find('.logobar').text()) - wordsToRead(d.find('.panel-group').text()) - wordsToRead(d.find('.google-analytics').text()) - wordsToRead(d.find('.comments').text());
                
                // Calculate reading time and add it where it's needed
                linkElement.find('.estimated-time').text('Reading time: ' + readingTime(totalWords) + ' min')
              
            }, 'html');
        } else {
        }
        
    });
}); 
</script>