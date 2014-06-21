

fans_home.dashboard = function () {
    return {

        /*
         @function： init_dashboard
         @param：none
         */
        init_dashboard: function () {

            //Background slideshow
            $('.main_board').backstretch([
                "../images/backgrounds/1.jpg",
                "../images/backgrounds/2.jpg",
                "../images/backgrounds/3.jpg"
            ], {duration: 3000, fade: 750});

            //Set hover event for every item circle.
            var $item_list = $(".item").children().filter('div');
            $item_list.hover(
                    function () {

                        $(this).find('.total_count').find('span').show();
                        $(this).find('.title_posts').show();
                        $(this).find('.title').hide();
                    },
                    function () {
                        $(this).find('.total_count').find('span').hide();
                        $(this).find('.title_posts').hide();
                        $(this).find('.title').show();
                    }
            );

            // Set hover event for every item circle.
            $item_list.click(function () {
                var detail_panel_id = $(this).data('detail_panel');
                $("#board_detail_show").find('.' + detail_panel_id).show().siblings().hide();
                $('.main_board').backstretch("resize");
            });

            //
            $($item_list[0]).click(function () {
               fans_home.life_post.life_picture_item_screen();
            });


            //Set click event for every item circle.
            //Show panel of it, then hide other
            $(".close_detail_btn").click(function () {
                $(this).parents(".hero-unit").hide().siblings(".detail_index").show();
                $('.main_board').backstretch("resize");
            });

             //Tooltips
            $(".close_detail_btn").tooltip();
            $(".show_detail_btn").tooltip();
            $('.social a.github').tooltip();
            $('.social a.cnblogs').tooltip();
            $('.social a.email').tooltip();
            $('.social a.resume').tooltip();

        },

        /*
         * change I18n default locale by ajax
         * @function： init_navigation_locale_change
         * @param：null
         * @returns null
         */
        init_navigation_locale_change: function () {
            $("#i18n_locale").change(function () {
                var params = {
                    locale: $(this).val(),
                    back_url: window.location.href
                };
                var options = {
                    url: "/sessions/change_locale",
                    type: "POST",
                    data: params,
                    success: function () {
                        location.reload()
                    }
                };
                $.ajax(options);
            })
        }
    }
}();