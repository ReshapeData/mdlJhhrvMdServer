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
    filename=var_file_expInfo_Acct()

    data <- readxl::read_excel(filename,sheet = "科目", col_types = c("text","text","text","text","text","text","text","text","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    tsui::run_dataTable2(id = 'mdlJHmd_Acct_resultView',data = data)


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


    filename=var_file_expInfo_Acct()
    data<-readxl::read_excel(filename,sheet = "科目", col_types = c("text","text","text","text","text","text","text","text","text"))
    data=as.data.frame(data)
    data=tsdo::na_standard(data)
    #上传至数据库至重分类暂存表
    tsda::db_writeTable2(token = '057A7F0E-F187-4975-8873-AF71666429AB',table_name = 'rds_hrv_src_md_acct_input',r_object = data,append = TRUE)
    #删除重分类已有数据
    mdlJHmdPkg::deleteCache_acct()
    #将暂存表数据插入重分类
    mdlJHmdPkg::insertCache_acct()
    #删除重分类暂存表数据
    mdlJHmdPkg::deleteAllcache_acct()
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
#' AcctServer()
AcctServer <- function(input,output,session,dms_token) {
  #演示功用1
  btn_preview_AcctServer(input,output,session,dms_token)
  #演示功能2
  btn_Update_AcctServer(input,output,session,dms_token)



}
