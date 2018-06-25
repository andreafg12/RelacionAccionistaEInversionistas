$(document).ready(function() {
     // Handler for .ready() called. action="<%=request.getContextPath()%>/descargar" 
	var fecha = new Date();  
    var anio=fecha.getFullYear(); 
    var x = document.getElementById("anioseleccion"); 
    var i= 2;
    while(i>0){
   	 var opcion=document.createElement("option");
        --i;
   	 opcion.value=--anio;
   	 opcion.text= anio;
   	 x.add(opcion);
     } 
	///var selectBox = $("select").selectBoxIt();
	$("#numeroCuentaInver").keypress(function(event){
		 console.log(event.key);
		 var s= $("#numeroCuentaInver"); 
		 if(!(/^([0-9])+$/.test(event.key))){
			 event.preventDefault();
			 /*var valor =s.val().replace(/^([Aa-zZ])*$/,"");
			 $("#numeroCuentaInver").val(valor)*/
		 }
	});
	
	var verifyCallback = function(response) {
	    alert(response);
	};

	var widgetId1;
	var onloadCallback = function() {
		widgetId1 = grecaptcha.render('example1', {
		     'theme' : 'light'
		});	
		widgetId1 = grecaptcha.getResponse(widgetId1);
	}

     $("#btn-contactenos").click(function(event) {
    	 if(validarform()){
    		 downloadFileAjax("#commentForm");
    	 }
     });
 });



function validarform() {
	var bool = true;
	var bolcert= false;
 	var tipo_ident = $("#tipo_identificacion-ct").val();
 	var aniosel = $("#anioseleccion").val();
 	var certificadoOrdinario = $("#checkCo").prop("checked");
	var certificadoPreferecial = $("#checkCp").prop("checked");
	var checkCondiciones=$("#checkCondiciones").prop("checked");
	var responserecap =grecaptcha.getResponse(); 
	
	if(!responserecap){
		bool = false;
		$("#logoError").css("display","table");
		$("#TextError").css("display","table");
	} 
	
	if(certificadoOrdinario || certificadoPreferecial){
		var bolcert= true;
	}
	 var nidentificacin=$("#nroidentificacion").val();
	if (!nidentificacin) {
		bool = false;
		$("#NumeroIdentificacion").css("display","table");
	}
	
	var numeroCuenta = $("#numeroCuentaInver").val();
	if (!numeroCuenta) {
		bool= false;
		$("#numeroCuentaInverError").css("display","table");
	}
	if((!tipo_ident) || (!aniosel)	|| (!bolcert) || (!checkCondiciones)){
		bool= false ;
		$("#logoError").css("display","table");
		$("#TextError").css("display","table");
	}
	
	if(!checkCondiciones){
		bool = false;
		$("#politicascheck").css("display","table");
	}
	return bool;
}

function downloadFileAjax(form) {
	var isValido = false;
	$.ajax({
		url: $(form).attr('action'),
		data: $(form).serialize(),
		type : "POST",
		async : false,
		success : function(evt) {
			if (evt.indexOf("ERROR") != -1) {
				isValido = false;
			} else {
				isValido = true;
			}
		}
	});
	
	if (!isValido) {					
		$.colorbox({inline:true, href:"#mensaje-error-certificado", width:"600px", height:"250px", scrolling: false,onClosed:function(){
 			location.reload(true);
 	    }});
		return false;
	}
	
	$("#commentForm").submit();
	limpiarCampos("#commentForm");
}

function limpiarCampos(form){
	$(form).find(':input').each(function() {
        switch(this.type) {
            case 'select-one':
            	$(this).selectBoxIt().data("selectBox-selectBoxIt").selectOption(' ');
            case 'text':
                 $(this).val('');
            case 'checkbox':
            	this.checked = false;
            case 'textarea':
                if($(this).attr('id') == "g-recaptcha-response")
               	 grecaptcha.reset();

        }
    });
}

