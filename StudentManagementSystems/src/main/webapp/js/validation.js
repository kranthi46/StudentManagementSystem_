document.addEventListener("DOMContentLoaded", function () {

    const forms = document.querySelectorAll("form");

    forms.forEach(function (form) {

        form.addEventListener("submit", function (event) {

            const requiredFields =
                form.querySelectorAll("[required]");

            let valid = true;

            requiredFields.forEach(function (field) {

                if (field.value.trim() === "") {
                    valid = false;
                    field.style.border = "2px solid red";
                } else {
                    field.style.border = "";
                }
            });

            if (!valid) {
                event.preventDefault();
                alert("Please fill all required fields.");
            }
        });
    });
});