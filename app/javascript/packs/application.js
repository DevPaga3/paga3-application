require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("./animate")
require("jquery")

document.addEventListener("turbolinks:load", function(event) {

    jQuery(document).ready(function ($) {

        if ($('#profile_have_credit').is(':checked')) {
            $("#text_not_credit").hide()
            $("#box_amount_credit").show()
        } else {
            $("#box_amount_credit").hide()
            $("#text_not_credit").show()
        }

        $('#profile_have_credit').click(function () {
            if ($('#profile_have_credit').is(':checked')) {
                $("#text_not_credit").hide()
                $("#box_amount_credit").show()
            } else {
                $("#box_amount_credit").hide()
                $("#text_not_credit").show()
            }
        })

        //Create next and prev effect to edit profile fields
        const slidePage = document.querySelector(".slide-page");
        const progressText = document.querySelectorAll(".step p");
        const progressCheck = document.querySelectorAll(".step .check");
        const bullet = document.querySelectorAll(".step .bullet");
        let current = 1;

        /* first prev */
        $("#prev-1").click(function(event){
            event.preventDefault();
            slidePage.style.marginLeft = "0%";
            bullet[current - 2].classList.remove("active");
            progressCheck[current - 2].classList.remove("active");
            progressText[current - 2].classList.remove("active");
            current -= 1;
        });

        /* second prev */
        $("#prev-2").click(function(event){
            event.preventDefault();
            slidePage.style.marginLeft = "-25%";
            bullet[current - 2].classList.remove("active");
            progressCheck[current - 2].classList.remove("active");
            progressText[current - 2].classList.remove("active");
            current -= 1;
        });

        /* first next */
        $('#firstNext').click(function(event){
            slidePage.style.marginLeft = "-25%";
            bullet[current - 1].classList.add("active");
            progressCheck[current - 1].classList.add("active");
            progressText[current - 1].classList.add("active");
            current += 1;
            event.preventDefault();
        });
        
        /* second next */
        $("#next-1").click(function(event){
            event.preventDefault();
            slidePage.style.marginLeft = "-50%";
            bullet[current - 1].classList.add("active");
            progressCheck[current - 1].classList.add("active");
            progressText[current - 1].classList.add("active");
            current += 1;
        });

        //submit
        $(".submit").click(function () {
            bullet[current - 1].classList.add("active");
            progressCheck[current - 1].classList.add("active");
            progressText[current - 1].classList.add("active");
            current += 1;
        });
    });
})

