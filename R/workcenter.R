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
#' btn_preview_WorkcenterServer()
btn_preview_WorkcenterServer <- function(input,output,session,dms_token) {
  var_file_expInfo_Workcenter=tsui::var_file(id='file_expInfo_Workcenter')

  shiny::observeEvent(input$btn_preview_Workcenter,{


    filename=var_file_expInfo_Workcenter()
    data <- readxl::read_excel(filename,sheet = "核算维度-责任中心",col_types = c("numeric","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    tsui::run_dataTable2(id = 'mdlJHmd_Workcenter_resultView',data = data)

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
#' btn_Update_WorkcenterServer()
btn_Update_WorkcenterServer <- function(input,output,session,dms_token) {

  var_file_expInfo_Workcenter=tsui::var_file(id='file_expInfo_Workcenter')

  shiny::observeEvent(input$'btn_Update_Workcenter',{


    filename=var_file_expInfo_Workcenter()
    data <- readxl::read_excel(filename,sheet = "核算维度-责任中心",
                               col_types = c("numeric","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    #上传至数据库至责任中心暂存表
    tsda::db_writeTable2(token = '057A7F0E-F187-4975-8873-AF71666429AB',table_name = 'rds_hrv_src_md_workcenter_input',r_object = data,append = TRUE)
    #删除责任中心已有数据
    mdlJhhrvMdPkg::deleteCache_workcenter()
    #将暂存表数据插入责任中心
    mdlJhhrvMdPkg::insertCache_workcenter()
    #删除责任中心暂存表数据
    mdlJhhrvMdPkg::deleteAllcache_workcenter()
    tsui::pop_notice("核算维度_责任中心更新成功")

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
#' btn_preview_WorkcenterServer()
#'
btn_download_WorkcenterServer <- function(input,output,session,dms_token) {
  
  shiny::observeEvent(input$btn_view_Workcenter,{
    data_Workcenter = mdlJhhrvMdPkg::ViewWorkcenter()
    
    tsui::run_dataTable2(id = 'dl_dataview_Workcenter',data =data_Workcenter )
    
    
    #下载数据
    tsui::run_download_xlsx(id = 'dl_dataview_Workcenter',data =data_Workcenter ,filename = '责任中心数据.xlsx')
    
    
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
#' buttonServer()
WorkcenterServer <- function(input,output,session,dms_token) {
  #演示功用1
  btn_preview_WorkcenterServer(input,output,session,dms_token)
  #演示功能2
  btn_Update_WorkcenterServer(input,output,session,dms_token)
  btn_download_WorkcenterServer(input,output,session,dms_token)



}
