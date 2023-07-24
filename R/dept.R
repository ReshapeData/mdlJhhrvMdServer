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
#' btn_preview_DeptServer()
#'
btn_preview_DeptServer <- function(input,output,session,dms_token) {

  var_file_expInfo_Dept=tsui::var_file(id='file_expInfo_Dept')


  shiny::observeEvent(input$btn_preview_Dept,{
    filename=var_file_expInfo_Dept()

    data <- readxl::read_excel(filename,sheet = "核算维度-部门对照", col_types = c("text","text","text","text","text","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    tsui::run_dataTable2(id = 'mdlJHmd_Dept_resultView',data = data)


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
#' btn_Update_DeptServer()
btn_Update_DeptServer <- function(input,output,session,dms_token) {
  var_file_expInfo_Dept=tsui::var_file(id='file_expInfo_Dept')


  shiny::observeEvent(input$'btn_Update_Dept',{


    filename=var_file_expInfo_Dept()
    data<-readxl::read_excel(filename,sheet = "核算维度-部门对照", col_types = c("text","text","text","text","text","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    #上传至数据库至重分类暂存表
    tsda::db_writeTable2(token = '057A7F0E-F187-4975-8873-AF71666429AB',table_name = 'rds_hrv_src_md_dept_input',r_object = data,append = TRUE)
    #删除重分类已有数据
    mdlJhhrvMdPkg::deleteCache_dept()
    #将暂存表数据插入重分类
    mdlJhhrvMdPkg::insertCache_dept()
    #删除重分类暂存表数据
    mdlJhhrvMdPkg::deleteAllcache_dept()
    tsui::pop_notice("核算维度-部门对照更新成功")

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
#' btn_preview_DeptServer()
#'
btn_download_DeptServer <- function(input,output,session,dms_token) {
  
  shiny::observeEvent(input$btn_view_Dept,{
    data_Dept = mdlJhhrvMdPkg::ViewDept()
    
    tsui::run_dataTable2(id = 'dl_dataview_Dept',data =data_Dept )
    
    
    #下载数据
    tsui::run_download_xlsx(id = 'dl_dataview_Dept',data =data_Dept ,filename = '部门数据.xlsx')
    
    
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
#' DeptServer()
DeptServer <- function(input,output,session,dms_token) {
  #演示功用1
  btn_preview_DeptServer(input,output,session,dms_token)
  #演示功能2
  btn_Update_DeptServer(input,output,session,dms_token)
  btn_download_DeptServer(input,output,session,dms_token)



}
