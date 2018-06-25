<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<%@taglib prefix="c_rt" uri="http://java.sun.com/jstl/core_rt"%>
<portlet:defineObjects />
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>

<body>
	<script src="https://www.google.com/recaptcha/api.js" async defer></script>
	

	<form id="commentForm" action="<portlet:resourceURL />" method="post">
		<div id="wrapper">
			<div class="intro">
				<p>Apreciado accionista, tenga en cuenta que si usted tiene acciones
					ordinarias y preferenciales, se le generará un Certificado de Renta
					por tipo de acción. <br /> <br /> * Si usted no conoce su número
					de Cuenta Inversionista por favor comuniquese con el Deceval al
					teléfono 307 7127 en Bogotá o al 018000111901 en el resto del país.<br />
					<br /> Si presenta inconvenientes con alguna de las anteriores
					opciones, puede remitir un correo electrónico al buzón
					Adriana.Gonzales@corficolombiana.com</p>
			</div>
			<div id="content-form">
				<div class="campos">
					<label class="campo mensaje-error-recuadro">Tipo de Identificación:</label>
					<div class="camp campoSelect">
						<select name="tipo_identificacion" id="tipo_identificacion-ct" class="customSelect htmlTipoIdentificacionPersona mensaje-error-recuadro" >
							<option value="">Seleccione Uno…</option>
							<option value="1">CC</option>
							<option value="2">CE</option>
							<option value="4">NIP</option>
							<option value="5">NIT</option>
							<option value="6">PAP</option>
							<option value="7">TI</option>
						</select> 
					</div>
				</div>

				<div class="campos ">
					<div class="campo identificacion " style="width: CidCi;">
						<label>Número documento de Identificación:</label>
						<div>
							<input type="text" name="nroidentificacion" id="nroidentificacion" class="nro_identificacion mensaje-error-recuadro " value="" maxlength="20" placeholder="Escriba su número de identificación.." >
						</div>
					</div>
					<span id="NumeroIdentificacion" style="display: none" class="mensaje-error2-ct " id="mensaje-nro_identificacion "> El número de identificación debe ser formato numérico </span>
				</div>

				<div class="dos-columnas ">
					<div class="campos ">
						<label>Número de Cuenta Inversionita*</label>
						<div class="camp ">
							<input type="text" name="numeroCuentaInver" id="numeroCuentaInver" class="required email mensaje-error-recuadro" value="" maxlength="30" placeholder="Escriba su cuenta de inversionista." />
						</div>
						<span id="numeroCuentaInverError" style="display: none" class="mensaje-error2-ct ">El número de cuenta debe ser formato numérico  </span>
					</div>
					<div class="campos">
						<label class="campo mensaje-error-recuadro ">Año del certificado:</label>
						<div class="camp campoSelect ">
							<select name="anioseleccion" id="anioseleccion" class="customSelect htmlTipoIdentificacionPersona mensaje-error-recuadro ">
								<option value="">Seleccione Uno…</option>
								<!-- 
								 <option value="2016">2016</option>
								<option value="2015">2015</option>
								-->
							</select>
						</div>
						<div class="check checkbox aceptarCondiciones campo" style="width: auto;">
							<input type="hidden" id="TipoCertificado" name="TipoCertificado" value="" />
					        <input type="checkbox" name="checkCo" id="checkCo" class="checkbox" value="true" />
					        <label for="checkCo" class="elemento imgCheck imgCheckCond" id="checkCo"> <span></span></label>
					        <label for="checkCo2" class="txtCheck txtCheckCond">Ordinario</label>
					    </div>
						<div class="check checkbox aceptarCondiciones campo " style="width: auto;">
							<input type="hidden" id="TipoCertificado" name="TipoCertificado" value="" />
					        <input type="checkbox" name="checkCp" id="checkCp" class="checkbox" value="true" />
					        <label for="checkCp" class="elemento imgCheck imgCheckCond" id="checkCp"> <span></span></label>
					        <label for="checkCp2" class="txtCheck txtCheckCond">Preferencial</label>
						</div>

					</div>

					<div class="campos ">
						<div class="content-elements ">
							<!--  <div class="campo">
								<label for="captcha ">*Digite los caracteres que aparecen en la siguiente imagen:</label>
							</div>-->

							<div class="g-recaptcha"
								data-sitekey='<%=renderRequest.getPreferences().getValue("recaptchaKey","")%>'></div>
							<input type="hidden" class="hiddenRecaptcha required"
								name="hiddenRecaptcha" id="hiddenRecaptcha">
								<input type="hidden" class="hiddenRecaptcha required"
								name="<%=renderRequest.getPreferences()%>" id="hiddenRecaptcha">
							<!--  <div class="icon-img-clave "></div>
							<div class="campoComentarios3 ">
								<input type="text" name="captchaIngresado "
									id="captchaIngresado " class="required " maxlength="5 "
									autocomplete="off" />
							</div>-->
							<div class="mensaje error2 ">
								<span style="display: none" class="mensaje-error2 ">Este campo es requerido</span>
							</div>
							
						</div>
					</div>
					<div class="campos ">
						<div class="camp habeas-data ">
							<p class="txt-habeas-data ">
							<div class="txt-habeas ">
								<p>1.Para efectos de acceder a este trámite (petición,
									quejas o reclamos ), la Corporación y/ o sus Filiales requieren
									autorización, ya que suministrará sus datos personales.</p>
								<br /> <br /> <a>2.Políticas de Tratamiento de Datos
									Personales</a>
								</p>
								<br />
								<p>
									<b style="font-weight: bold;">AUTORIZACIÓN USO DE DATOS
										PERSONALES</b>
								</p>
								<br />
								<p>En mi calidad de Titular de la Información declaro
									expresamente que autorizo a CORFICOLOMBIANA S.A. y/o sus
									filiales, subsidiarias o vinculadas* para acceder, almacenar,
									consultar, utilizar y compartir mis datos personales
									mencionados anteriormente, los cuales se han suministrado con
									el fin de ser utilizados para contestar la petición, queja o
									reclamo que elevo con la presente, conforme la Política de
									Tratamiento de Datos Personales.</p>
								<br />
								<p>Como titular de la información, me asisten los derechos
									previstos en las Leyes 1266 de 2008 y 1581 de 2012. En
									especial, me asiste el derecho a conocer, actualizar,
									rectificar y/o suprimir mis datos personales en los términos
									del numeral 8 de la Política de Tratamiento de Datos
									Personales.</p>
								<br />
								<p>*Para efectos de la presente autorización, se entiende
									por vinculada la persona natural o jurídica relacionada directa
									o indirectamente con base en los criterios consignados en los
									artículos 2.1.2.1.10, 2.1.2.1.11 y 2.1.2.1.12 del Decreto 2555
									de 2010 y los artículos 26, 27 y 28 de la Ley 222 de 1995.</p>
								</p>
							</div>
							</p>

							<div class="campos ">

								<div class="check checkbox aceptarCondiciones campo "
									style="width: auto;">
									<input type="hidden" id="terminos " name="terminos" value="" />
									<input type="checkbox" name="checkCondiciones" id="checkCondiciones" class="checkbox " value="true" /> 
									<label for="checkCondiciones" class="elemento imgCheck imgCheckCond " id="checkCondiciones">
										<span></span>
									</label> <label for="checkCond " class="txtCheck txtCheckCond ">He
										leído y acepto las políticas de tratamiento de datos
										personales.</label>
								</div>
								<span id="politicascheck" style="display: none" class="mensaje-error2">Se
									deben leer y aceptar las políticas de tratamiento de datos
									personales</span>
							</div>
						</div>


					</div>


					<div id="logoError" style="display: none" class="icon-admiracion "></div>
					<div  id="TextError" style="display: none" class="error-form ">No se han diligenciado todos los campos.</div>
					<div class="btn-filter"  style="margin-bottom: 200px ">
						<input type="button" id="btn-contactenos" value="Enviar "
							class="enviar first-child " />
					</div>
				</div>
			</div>
		</div>

		<div style="display: none">
			<div id="mensaje-error-certificado">


				<div class="texto-error-certificado">
					<p>En este momento estamos presentando problemas técnicos. Por
						favor comuniquese con el Call Center 018000 522 238 – Bogotá (571)
						3535066</p>
				</div>
			</div>
		</div>

		
	</form>


</body>
