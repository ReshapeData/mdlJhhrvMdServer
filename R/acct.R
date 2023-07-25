#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' btn_preview_AcctServer()
#'
btn_preview_AcctServer <- function(input,output,session,dms_token) {
  

  var_file_expInfo_Acct=tsui::var_file(id='file_expInfo_Acct')
  


  shiny::observeEvent(input$btn_preview_Acct,{
    if (is.null(var_file_expInfo_Acct())){
      
      tsui::pop_notice("请先上传文件")
      
      
      
    }else{
      filename=var_file_expInfo_Acct()
      data <- readxl::read_excel(filename,sheet = "科目", col_types = c("text","text","text","text","text","text","text","text","text"))
      data=as.data.frame(data)
      data=tsdo::na_standard(data)
      tsui::run_dataTable2(id = 'mdlJHmd_Acct_resultView',data = data)
    }

  })


}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' btn_Update_AcctServer()
btn_Update_AcctServer <- function(input,output,session,dms_token) {
  var_file_expInfo_Acct=tsui::var_file(id='file_expInfo_Acct')


  shiny::observeEvent(input$'btn_Update_Acct',{
    if (!is.null(var_file_expInfo_Acct())){
      filename=var_file_expInfo_Acct()
      data<-readxl::read_excel(filename,sheet = "科目", col_types = c("text","text","text","text","text","text","text","text","text"))
      data=as.data.frame(data)
      data=tsdo::na_standard(data)
      #上传至数据库至重分类暂存表
      tsda::db_writeTable2(token = '9ADDE293-1DC6-4EBC-B8A7-1E5CC26C1F6C',table_name = 'rds_hrv_src_md_acct_input',r_object = data,append = TRUE)
      #删除重分类已有数据
      mdlJhhrvMdPkg::deleteCache_acct()
      #将暂存表数据插入重分类
      mdlJhhrvMdPkg::insertCache_acct()
      #删除重分类暂存表数据
      mdlJhhrvMdPkg::deleteAllcache_acct()
      tsui::pop_notice("科目更新成功")
    }else{
      tsui::pop_notice("请先上传文件")
    }
    

  })
}

#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' btn_preview_AcctServer()
#'
btn_download_AcctServer <- function(input,output,session,dms_token) {
  
  shiny::observeEvent(input$btn_view_Acct,{
    data_acct = mdlJhhrvMdPkg::ViewAcct()
    
    tsui::run_dataTable2(id = 'mdlJHmd_Acct_resultView',data =data_acct )
    
    
    #下载数据
    tsui::run_download_xlsx(id = 'mdlJHmd_Acct_resultView',data =data_acct ,filename = '科目数据.xlsx')
    
    
  })
  
}

#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' AcctServer()
AcctServer <- function(input,output,session,dms_token) {
  #演示功用1
  btn_preview_AcctServer(input,output,session,dms_token)
  #演示功能2
  btn_Update_AcctServer(input,output,session,dms_token)
  btn_download_AcctServer(input,output,session,dms_token)
  



}
