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
#' btn_preview_AcctreclassServer()
#'
btn_preview_AcctreclassServer <- function(input,output,session,dms_token) {

  var_file_expInfo_Acctreclass=tsui::var_file(id='file_expInfo_Acctreclass')


  shiny::observeEvent(input$btn_preview_Acctreclass,{
    filename=var_file_expInfo_Acctreclass()

    data <- readxl::read_excel(filename,sheet = "核算维度-重分类", col_types = c("numeric","text","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    tsui::run_dataTable2(id = 'mdlJHmd_Acctreclass_resultView',data = data)


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
#' btn_Update_AcctreclassServer()
btn_Update_AcctreclassServer <- function(input,output,session,dms_token) {
  var_file_expInfo_Acctreclass=tsui::var_file(id='file_expInfo_Acctreclass')


  shiny::observeEvent(input$'btn_Update_Acctreclass',{


    filename=var_file_expInfo_Acctreclass()
    data<-readxl::read_excel(filename,sheet = "核算维度-重分类", col_types = c("numeric","text","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    #上传至数据库至重分类暂存表
    tsda::db_writeTable2(token = '057A7F0E-F187-4975-8873-AF71666429AB',table_name = 'rds_hrv_src_md_acctreclass_input',r_object = data,append = TRUE)
    #删除重分类已有数据
    mdlJhhrvMdPkg::deleteCache_acctreclass()
    #将暂存表数据插入重分类
    mdlJhhrvMdPkg::insertCache_acctreclass()
    #删除重分类暂存表数据
    mdlJhhrvMdPkg::deleteAllcache_acctreclass()
    tsui::pop_notice("核算维度_重分类更新成功")

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
#' btn_preview_AcctreclassServer()
#'
btn_download_AcctreclassServer <- function(input,output,session,dms_token) {
  
  shiny::observeEvent(input$btn_view_Acctreclass,{
    data_Acctreclass = mdlJhhrvMdPkg::ViewAcctreclass()
    
    tsui::run_dataTable2(id = 'dl_dataview_Acctreclass',data =data_Acctreclass )
    
    
    #下载数据
    tsui::run_download_xlsx(id = 'dl_dataview_Acctreclass',data =data_Acctreclass ,filename = '重分类数据.xlsx')
    
    
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
#' AcctreclassServer()
AcctreclassServer <- function(input,output,session,dms_token) {
  #演示功用1
  btn_preview_AcctreclassServer(input,output,session,dms_token)
  #演示功能2
  btn_Update_AcctreclassServer(input,output,session,dms_token)
  btn_download_AcctreclassServer(input,output,session,dms_token)



}
