$(document).ready(function() {
    $('#user_password').keyup(function(){
        $('#result').html(checkStrength($('#user_password').val()))
    })
    function checkStrength(password){
        //initial strength
        var strength = 0
        //if the password length is less than 6, return message.
        if (password.length < 8) {
            $('#result').removeClass()
            $('#result').addClass('short');
            return 'Too short';
        }
        //if value is less than 8
        if (strength < 8 ) {
            $('#result').removeClass()
            $('#result').addClass('strong');
            $('.short').hide();
            var a = $('.strong').show();
            return a;
        }
    }
});