package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Empresa

class EmpresaHome {
	
	def void save(Empresa unaEmpresa){
   
		SessionManager.getSession().saveOrUpdate(unaEmpresa)
	}
	
	def Empresa get(String cuit){
		
		return SessionManager.getSession().get(typeof(Empresa),cuit) as Empresa
    }
}