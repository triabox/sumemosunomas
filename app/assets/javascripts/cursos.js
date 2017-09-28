// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(function () {
    var today = Date.now();
    $('#datetimepicker6').datetimepicker({format: 'DD/MM/YYYY', minDate: today});
    $('#datetimepicker7').datetimepicker({
        format: 'DD/MM/YYYY',
        useCurrent: false,
        minDate: today
    });
    $("#datetimepicker6").on("dp.change", function (e) {
        useCurrent: false
        $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
    });
    $("#datetimepicker7").on("dp.change", function (e) {
        $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
    });
    $('#datetimepicker4').datetimepicker({
        format: 'LT',
        useCurrent: false,
    });
    $('#datetimepicker3').datetimepicker({
        useCurrent: false,
        format: 'LT',
    });
    $('#datetimepicker1').datetimepicker({
        useCurrent: false,
        format: 'DD/MM/YYYY',
    });


    /*
     * Add collapse and remove events to boxes
     */
    $("[data-widget='collapse']").click(function () {
        //Find the box parent
        var box = $(this).parents(".box").first();
        //Find the body and the footer
        var bf = box.find(".box-body, .box-footer");
        if (!box.hasClass("collapsed-box")) {
            box.addClass("collapsed-box");
            bf.slideUp();
        } else {
            box.removeClass("collapsed-box");
            bf.slideDown();
        }
    });
    $('#collapse1').on('shown.bs.collapse', function (e) {
        google.maps.event.trigger(document.getElementById('map-geo'), "resize");
    });
});

$(document).ready(function () {
    //Initialize tooltips
    $('.nav-tabs > li a[title]').tooltip();

    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var $target = $(e.target);

        if ($target.parent().hasClass('disabled')) {
            return false;
        }
    });

    $(".next-step").click(function (e) {
        var $active = $('.wizard .nav-tabs li.active');
        $active.next().removeClass('disabled');
        $active.next().find('a[data-toggle="tab"]').click();
    });

    $(".one-next-step").click(function (e) {
        var nombre = document.getElementById("curso_nombre");
        var descripcion = document.getElementById("curso_descripcion");
        var contenido = document.getElementById("curso_contenido");
        var tipoActividad =  document.getElementById("curso_tipo_actividad");
        var ret = true;
        if (isEmpty(nombre.value)) {
            nombre.className = "form-control red-border";
            ret = false;
        }
        if (isEmpty(descripcion.value)) {
            descripcion.className = "form-control red-border";
            ret = false;
        }
        if (isEmpty(contenido.value)) {
            contenido.className = "form-control red-border";
            ret = false;
        }
        if (isEmpty(tipoActividad.value)) {
            tipoActividad.className = "form-control red-border";
            ret = false;
        }
        if (ret) {
            var $active = $('.wizard .nav-tabs li.active');
            $active.next().removeClass('disabled');
            $active.next().find('a[data-toggle="tab"]').click();
        }
    });

    $(".two-next-step").click(function (e) {
        var cupos = document.getElementById("curso_cupos");
        var becados = document.getElementById("curso_relacion_b_nb");
        var ret = true;
        if (isEmpty(cupos.value)) {
            cupos.className = "form-control red-border";
            ret = false;
        }
        if (isEmpty(becados.value) || becados.value < 1) {
            becados.className = "form-control red-border";
            ret = false;
        }
        if (ret) {
            var $active = $('.wizard .nav-tabs li.active');
            $active.next().removeClass('disabled');
            $active.next().find('a[data-toggle="tab"]').click();
            google.maps.event.trigger(document.getElementById('map-geo'), "resize");
        }
    });

    $(".three-next-step").click(function (e) {
        var fechaInicio = document.getElementById("curso_fecha_inicio");
        var fechaFin = document.getElementById("curso_fecha_fin");
        var ubicacion = document.getElementById("location_address");
        var ret = true;
        if (isEmpty(fechaInicio.value)) {
            fechaInicio.className = "form-control red-border";
            ret = false;
        }
        if (isEmpty(fechaFin.value)) {
            fechaFin.className = "form-control red-border";
            ret = false;
        }
        if (isEmpty(ubicacion.value)) {
            ubicacion.className = "form-control red-border";
            ret = false;
        }
        if (ret) {
            var $active = $('.wizard .nav-tabs li.active');
            $active.next().removeClass('disabled');
            $active.next().find('a[data-toggle="tab"]').click();
        }
    });

    $(".next-step-calendar").click(function (e) {
        if (nextTab(e)) {
            var $active = $('.wizard .nav-tabs li.active');
            $active.next().removeClass('disabled');
            $active.next().find('a[data-toggle="tab"]').click();
        }
    });
    $(".nuevo_curso").click(function (e) {
        var tarjeta = document.getElementById('curso_tarjeta');
        var efectivo = document.getElementById('curso_efectivo');

        if (!tarjeta.checked && !efectivo.checked) {
            document.getElementById('tarjeta').style.color = "darkred";
            document.getElementById('efectivo').style.color = "darkred";
        }
    });
    $(".prev-step").click(function (e) {
        var $active = $('.wizard .nav-tabs li.active');
        prevTab($active);
    });
});

function nextTab(elem) {
    var ret = true, name = "", inicio = "", fin = "";
    var checkboxes = document.getElementsByClassName("check");
    for (var x = 0; x < checkboxes.length; x++) {
        name = checkboxes[x].name.substring(0, checkboxes[x].name.length - 3);
        inicio = name + "_inicio";
        fin = name + "_fin";
        if (checkboxes[x].checked) {
            document.getElementById(inicio).className = "form-control";
            document.getElementById(fin).className = "form-control";
            if (isEmpty(document.getElementById(inicio).value) || !document.getElementById(inicio).value.match(/^([2][0-3]|[01]?[0-9])([.:][0-5][0-9])?$/)) {
                ret = false;
                document.getElementById(inicio).className = "form-control red-border";
            }
            if (isEmpty(document.getElementById(fin).value) || !document.getElementById(fin).value.match(/^([2][0-3]|[01]?[0-9])([.:][0-5][0-9])?$/)) {
                ret = false;
                document.getElementById(fin).className = "form-control red-border";
            }
        }
    }
    return ret;
}
function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();
}

function mostrar(dia) {
    var check = dia + 'Chk';
    var checkbox = document.getElementById(check);
    if (checkbox.checked) {
        document.getElementById("pregunta").style.display = "block";
        document.getElementById(dia).style.display = "block";
    }
    else {
        document.getElementById(dia).style.display = "none";
    }
}

function mostrarTipoPago() {
    var tarjeta = document.getElementById('curso_tarjeta');
    var efectivo = document.getElementById('curso_efectivo');

    if (tarjeta.checked) {
        document.getElementById('pago_tarjeta').style.display = "block";
    } else {
        document.getElementById('pago_tarjeta').style.display = "none";
    }
}

function mostrarMapa(){
    document.getElementById('map-geo').style.display = "block";
}

function mostrarTipoPagoEnInscripcion() {
    var tarjeta = document.getElementById('curso_tarjeta');
    var efectivo = document.getElementById('curso_efectivo');

    if (efectivo.checked) {
        document.getElementById('pago_efectivo_boton').style.display = "block";
    } else {
        document.getElementById('pago_efectivo_boton').style.display = "none";
    }
    
    if (tarjeta.checked) {
        document.getElementById('pago_tarjeta_boton').style.display = "block";
    } else {
        document.getElementById('pago_tarjeta_boton').style.display = "none";
    }

}

function isEmpty(str) {
    return (!str || 0 === str.length);
}

function opendatetimepicker(calendar) {
    $('#' + calendar).click();
}

