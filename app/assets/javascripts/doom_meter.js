function Like(self, id) {
    $.ajax({
        type: "POST",
        dataType: "json",
        data: { doom_id: id },
        url: '/like',
        success: function(response){
            self.removeClass(response['unheart']).addClass(response['heart']);
            self.parent().find('span').text(response['count'])
        }
    });
}

function getDoom(self, type, id) {
    $('.doom_btn').removeClass('active_btn');
    self.addClass('active_btn');
    $.ajax({
        type: "POST",
        dataType: "json",
        data: { doom_type: type, id: id },
        url: '/get_dooms',
        success: function(response){
            $('.doom_info_block').html(response.html);
            $('#doom-meter').html(response.doom_meter);
            resizeMeter()
        }
    });
}

function changeDmeter() {
    var id = $('#dmeter').val().trim().split(/[\s,]+/).join('-');
    window.location.href = '/doom_meter/' + id;
}

function showListLevels() {
    if ($('#list_levels').css('display') == 'block') {
        $('#list_levels').css('display', 'none');
        $('.because').css('display', 'block');
    }
    else {
        $('#list_levels').css('display', 'block');
        $('.because').css('display', 'none');
        $('#doom_level').prop('disabled', true)
    }
}

function hideListLevels(self) {;
    var text = self.find('a').text();
    $('#list_levels').css('display', 'none');
    $('.because').css('display', 'block');
    $('#doom_level').val(text);
    $('#doom_level').prop('disabled', '')
}

setTimeout(function() {
    $('#flash-message').fadeOut('fast');
}, 6000);

$( document ).ready(function() {
    resizeMeter();
});

function resizeMeter() {
    if (window.innerWidth >= 1700) { $('.main_doom_meter')[0].style.transform = 'none' }
    if (window.innerWidth < 1700 && window.innerWidth >= 1600) { $('.main_doom_meter')[0].style.transform = 'scale(0.915)' }
    if (window.innerWidth < 1600 && window.innerWidth >= 1500) { $('.main_doom_meter')[0].style.transform = 'scale(0.86)' }
    if (window.innerWidth < 1500 && window.innerWidth >= 1400) { $('.main_doom_meter')[0].style.transform = 'scale(0.785)' }
    if (window.innerWidth < 1400 && window.innerWidth >= 1300) { $('.main_doom_meter')[0].style.transform = 'scale(0.708)' }
    if (window.innerWidth < 1300 && window.innerWidth >= 1200) { $('.main_doom_meter')[0].style.transform = 'scale(0.632)' }
    if (window.innerWidth < 1200 && window.innerWidth >= 1100) { $('.main_doom_meter')[0].style.transform = 'scale(0.566)' }
    if (window.innerWidth < 1100 && window.innerWidth >= 1000) { $('.main_doom_meter')[0].style.transform = 'scale(0.49)' }
    if (window.innerWidth < 1000 && window.innerWidth >= 900) { $('.main_doom_meter')[0].style.transform = 'scale(0.413)' }
    if (window.innerWidth < 900 && window.innerWidth >= 800) { $('.main_doom_meter')[0].style.transform = 'scale(0.336)' }
    if (window.innerWidth < 800 && window.innerWidth >= 700) { $('.main_doom_meter')[0].style.transform = 'scale(0.259)' }
    if (window.innerWidth < 700 && window.innerWidth >= 600) { $('.main_doom_meter')[0].style.transform = 'scale(0.183)' }
    if (window.innerWidth < 600 && window.innerWidth >= 500) { $('.main_doom_meter')[0].style.transform = 'scale(0.106)' }
    if (window.innerWidth < 500) { $('.main_doom_meter')[0].style.transform = 'scale(0.088)' }
}

function sendInvite(id) {
    var email = $('#invite_email').val();
    $.ajax({
        type: "POST",
        dataType: "json",
        data: { id: id, email: email },
        url: '/send_invite',
        success: function(response){
            $('body').prepend('<div id=\"flash-message\"><strong>' + response.message + '</strong></div>');
        },
        error: function(error) {
            $('body').prepend('<div id=\"flash-message\">' + error.responseJSON.message + '</div>');
        }
    });
    setTimeout(function () {
        $('#flash-message').fadeOut('fast');
    }, 6000);
}

