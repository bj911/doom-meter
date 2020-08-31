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
}, 3000);