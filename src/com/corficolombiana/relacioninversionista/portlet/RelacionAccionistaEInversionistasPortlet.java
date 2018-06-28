package com.corficolombiana.relacioninversionista.portlet;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.portlet.PortletException;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.apache.log4j.Logger;

public class RelacionAccionistaEInversionistasPortlet extends javax.portlet.GenericPortlet {


	private static final String VIEW = "/jsp/RelacionInversionistaView.jsp";
	private static final String MSG_FILE_NOT_FOUND = "No se encontró el archivo";
	private static Logger logger = Logger.getLogger(RelacionAccionistaEInversionistasPortlet.class);


	protected void doView(RenderRequest request, RenderResponse response) throws PortletException, IOException {
		response.setContentType(request.getResponseContentType());

		try {
			PortletRequestDispatcher rd;
			rd = getPortletContext().getRequestDispatcher(VIEW);
			rd.include(request, response);

		} catch (Exception e) {
			logger.error("ERROR: " + e.getMessage());
		}
	}

	public void serveResource(ResourceRequest request, ResourceResponse response) throws PortletException, IOException {
		String documentoCliente =request.getParameter("nroidentificacion");
		String nombreArchivo = "";
		String numerocedula;
		String anio;
		String aniorequest =request.getParameter("anioseleccion");
		String[] valuesChecked=request.getParameterValues("tipoCertificado");
		String check="";
				
		logger.info("Size Values check: "+valuesChecked.length);

		try {
			String pathFile = request.getPreferences().getValue("pathFile", "");
			File file = new File(pathFile);
			Collection<File> filesToSend = new ArrayList<File>();
			if (file.isDirectory()) {
				for (String value  : valuesChecked) {
					for (File file2 : file.listFiles()) {
						nombreArchivo = file2.getName();
						numerocedula = nombreArchivo.substring(4, (nombreArchivo.length() - 11));
						anio = nombreArchivo.substring(nombreArchivo.length() - 8, (nombreArchivo.length() - 4));
						check = nombreArchivo.substring(2,4);
						if (anio.equals(aniorequest) && numerocedula.equals(documentoCliente) && value.equals(check)) {
							logger.info("Se encontro el archivo");
							filesToSend.add(new File(file2.getAbsolutePath()));
							break;
						}
						//terminacion  del if 
					}
				}
			}
			
			logger.info("Length files: "+filesToSend.size());
			if(filesToSend.isEmpty()) {
				throw new Exception(MSG_FILE_NOT_FOUND);
			}
			
			OutputStream outStream = null;
			FileInputStream des = null;
			outStream = response.getPortletOutputStream();
			if(filesToSend.size() > 1) {
				//Headers
				response.setContentType("application/zip");
				response.setProperty("Content-Disposition", "attachment; filename=\"certificados.zip\"");
				
				BufferedOutputStream bufferedOutputStream = null;
				ZipOutputStream zipOutputStream = null;
				bufferedOutputStream = new BufferedOutputStream(outStream);
				zipOutputStream = new ZipOutputStream(bufferedOutputStream);
				downloadListFile(filesToSend, zipOutputStream, des);
				
				if (zipOutputStream != null) {
					zipOutputStream.finish();
					zipOutputStream.flush();
					zipOutputStream.closeEntry();
				}
				
				bufferedOutputStream.close();
			} else {
				response.setContentType("application/octet-stream");
				response.setProperty("Content-disposition", "attachment; filename="+ nombreArchivo);
				downloadFile(filesToSend, response, outStream, des);
			}

		} catch (IOException e) {
			logger.error("ERROR: " + e.getMessage());
			response.getWriter().write("ERROR");
		} catch (Exception e) {
			logger.error("ERROR: " + e.getMessage());
			response.getWriter().write("ERROR");
		}
	}


	private void downloadFile(Collection<File> filesToSend, ResourceResponse response, OutputStream outStream, FileInputStream des) throws Exception {
		for(File f: filesToSend) {
			logger.info("length file: " + f.length()+" Nombre: "+ f.getName());
			response.setContentLength((int) f.length());
			try {
			des = new FileInputStream(f);
			byte[] buffer = new byte[4096];
			int byteRead = -1;
			while ((byteRead = des.read(buffer)) != -1) {
				outStream.write(buffer, 0, byteRead);
	
			}
			outStream.flush();
			outStream.close();
			} finally {
				if(des != null) {
					des.close();
				}
			}
		}
		
	}


	private void downloadListFile(Collection<File> filesToSend, ZipOutputStream zipOutputStream, FileInputStream des) throws Exception {		
		for(File f: filesToSend) {
			logger.info("length file: " + f.length()+" Nombre: "+ f.getName());
			ZipEntry zipEntry = null;
			
			try {
				des = new FileInputStream(f);
				zipEntry = new ZipEntry(f.getName());
				zipOutputStream.putNextEntry(zipEntry);
				byte[] buffer = new byte[1024];
				int byteRead = -1;
				while ((byteRead = des.read(buffer)) != -1) {
					zipOutputStream.write(buffer, 0, byteRead);
		
				}
			} catch (IOException e) {
				logger.info("Cannot find " + f.getAbsolutePath());
			} finally {
				des.close();
				if (zipEntry != null) {
					zipOutputStream.closeEntry();
				}
			}
		}
	}

}
