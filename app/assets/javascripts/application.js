// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require countdown_timer
//= require jquery.notifyBar
//= require dhtmlxcalendar
//= require jquery-ui-1.8.20.custom.min
//= require charts
//= require jquery.flot
//= require jquery.flot.tooltip
//= require highstock
//= require navbar
//= require waypoints.min
//= require script
//= require_tree .

//remove fields
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

//add more fields
function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}

function graph_id(th) {
    $("ul#xkgd li a").each(function() {
        $(this).css('font-weight', 'normal');
    });
    $(th).css('font-weight', 'bold');
}

var myCalendar;
function doOnLoad() {
    myCalendar = new dhtmlXCalendarObject(["calendar"]);
    myCalendar.setDate(new Date());
}

function setSens(id, k) {
    myCalendar.setSensitiveRange(null, new Date());
}

$(document).ready(function() {
    setTimeout(function() {
        $('#collexp > li > a.expanded + ul').slideToggle('medium');
        $('#collexp > li > a').click(function() {
            $('#collexp > li > a.expanded').not(this).toggleClass('expanded').toggleClass('collapsed').parent().find('> ul').slideToggle('medium');
            $(this).toggleClass('expanded').toggleClass('collapsed').parent().find('> ul').slideToggle('medium');
        });
    }, 250);
});

//$(function(){
//    $("input, textarea, select,file").uniform();
//});

//ajax loader

jQuery(document).ajaxStart(function(settings) {
    jQuery('#ajax-loader').show();
});
jQuery(document).ajaxStop(function() {
    jQuery('#ajax-loader').hide();
});


////scroll top
//$(document).ready(function() {
//
//    $(window).scroll(function() {
//        if ($(this).scrollTop() > 100) {
//            $('.scrollup').fadeIn();
//        } else {
//            $('.scrollup').fadeOut();
//        }
//    });
//
//    $('.scrollup').click(function() {
//        $("html, body").animate({
//            scrollTop: 0
//        }, 600);
//        return false;
//    });
//
//});

////styles for the radio button
//$(function(){
//    $.imageTick.logging = true;
//    $('input[type="radio"]').imageTick({
//        tick_image_path: "/assets/radio_button1.png",
//        no_tick_image_path: "/assets/radio-button.png",
//        image_tick_class: "radios"
//    });
//});


//without page reload change browser url

//$(function(){
//    $("a[rel='tab']").click(function(e){
//        pageurl = $(this).attr('href');
//        $.ajax({
//            url:pageurl+'?rel=tab',
//            success: function(data){
//                $('#header').css('display', 'none');
//                $('#maincontent').html(data);
//            }
//        });
//
//    if(pageurl!=window.location){
//        window.history.pushState({
//            path:pageurl
//        },'',pageurl);
//    }
//    return false;
//    });
//});
//
//$(window).bind('popstate', function() {
//    $.ajax({
//        url:location.pathname+'?rel=tab',
//        success: function(data){
//            $('#maincontent').html(data);
//        }
//    });
//});

//login popup

function login() {
    $.ajax({
        url: '/users/sign_in',
        success: function(data) {
            $("#popup_body").html(data);
            $("#overlay").show();
            $("#popup_box").show();
        }
    })
}

function buyer_users_path() {
    $.ajax({
        url: '/users/buyer',
        success: function(data) {
            $('#popup_body').html(data);
            $('#overlay').show();
            $('#popup_box').show();
        }
    })
}

function hide_popup() {

    if (jQuery('#popup_box')) {
        jQuery('#popup_body').html("");
        jQuery('#popup_box').hide();
    }
    if (jQuery('#overlay')) {
        jQuery('#overlay').hide();
    }
}

$(function() {
    $('.leftSec a img').click(function(e) {
        e.preventDefault();
        $('.midSec img').attr('src', $(this).attr('src'));
    });
});


$(function() {
    $('.pagination a').click(function() {
        $.getScript(this.href);
        return false;
    });
});

function get_username(ht) {
    $.ajax({
        url: "/users/username",
        data: {
            username: $(ht).val()
        },
        type: "PUT",
        success: function(data) {
            if (data == "Error") {
                alert("Error. Please try again");
            } else {
            }
        }
    });
}

$(document).ready(function() {
    var mouse_in_side = false;

    $('#popup_body').hover(function() {
        mouse_in_side = true;
    }, function() {
        mouse_in_side = false;
    });

    $(document).click(function() {
        if (mouse_in_side == false) {
            $("#overlay").hide();
            $("#popup_box").hide();
        }
    });
});
