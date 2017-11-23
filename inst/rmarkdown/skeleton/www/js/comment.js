<script>
    $(document).ready(function() {
        
        // Variable storing month names
        var months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
        
        // Get url of the file opened
        var reportUrl = document.location.href;
        
        // Set the comment identifier. This can be changes via markdown YAML settings. If set to "default" file name is used.
        var comment_id = $('#comment_id').text().trim();
        if (comment_id === 'Default') {
            comment_id = document.location.pathname.match(/[^\/]+$/)[0];
        }

        // Current epoch, later added to the file name to prevent cache
        var milliseconds = (new Date).getTime();
        
        // Function converting DB date to readable one
        toReadableDate = function(date) {
            return  date.substring(8,10) + " " + months[parseInt(date.substring(5,7)) - 1] + " " + date.substring(0,4) + " " + date.substring(11,16); 
        };
        
        pad = function(n, width, z) {
          z = z || '0';
          n = n + '';
          return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
        };
        
        $.ajax({
            url: "http://api.ea.ioki.pl:6677/retrieve_comments" + "?report=" + comment_id,
            type: "GET",
            success: function (data) {
                if (data.length !== 0) {
                    $.each(data, function(key, val) {
                        $('.show-comments').prepend( "<div class = 'single-comment'><div class = 'comment-author'><span>" + val.name + "</span></div><div class = 'date-email'>" + toReadableDate(val.date) + " | " + val.email + "</div><div class = 'comment-contents'>" + val.content + "</div></div>");
                    });
                } else {
                    $("#show-comments").html('<div id = "no-comments">No comments to show. Be the first one to comment.</div>');
                }
            }
        });
        
        // Save comment in DB
        $('#comment-form').submit(function(event) {
            // Prevent default posting of form
            event.preventDefault();
            
            // Get values from the form
            var author = $('#comment-author-fld').val();
            var email = $('#email-author-fld').val();
            var content = $('#comment-content-fld').val();
            var recipientEmail = $('#recipient-email').html();
            
            // Set proper date format
            var d = new Date();
            var month = months[d.getMonth()];
            var dateString = d.getDate() + " " + month + " " + d.getFullYear() + " " + d.getHours() + ":" + pad(d.getMinutes(), 2);
            
            if (author !== "" && content !== "" && email !== "") {
                // Run script saving the comment in a file
                $.ajax({
                    type: "POST",
                    url: "http://api.ea.ioki.pl:6677/add_comment",
                    data: {'report': comment_id, 'date':  dateString, 'name': author, 'email': email, 'content': content, 'recipient': recipientEmail, 'url': reportUrl},
                    success: function(data) {
                    },
                    error: function() {
                    }
                });
                
                // Add the comment for this session
                $('#no-comments').hide();
                $('.show-comments').prepend( "<div class = 'single-comment'><div class = 'comment-author'><span>" + author + "</span></div><div class = 'date-email'>" + dateString + " | " + email + "</div><div class = 'comment-contents'>" + content + "</div></div>");
                $('#comment-author-fld').val("");
                $('#comment-content-fld').val("");
                $('#email-author-fld').val("");
            } else {
                $('#modal-required').modal('show');
            }
        });
    });
</script>