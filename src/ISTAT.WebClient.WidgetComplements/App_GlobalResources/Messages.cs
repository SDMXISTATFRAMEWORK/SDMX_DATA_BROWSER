﻿using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading;
using System.Xml;

namespace ISTAT.WebClient.WidgetComplements.Model.App_GlobalResources
{
    public class Messages
    {
        public static string app_copyright { get { return GetString("app_copyright"); } }
        public static string app_description { get { return GetString("app_description"); } }
        public static string app_title { get { return GetString("app_title"); } }
        public static string app_version { get { return GetString("app_version"); } }
        public static string confirmation_criteria_clear { get { return GetString("confirmation_criteria_clear"); } }
        public static string error_ajax_generic { get { return GetString("error_ajax_generic"); } }
        public static string error_drag_slice_component_single { get { return GetString("error_drag_slice_component_single"); } }
        public static string error_invalid_session { get { return GetString("error_invalid_session"); } }
        public static string error_query_not_empty { get { return GetString("error_query_not_empty"); } }
        public static string error_results { get { return GetString("error_results"); } }
        public static string error_time_period_empty { get { return GetString("error_time_period_empty"); } }
        public static string format_codelist_code { get { return GetString("format_codelist_code"); } }
        public static string format_dataflow_id { get { return GetString("format_dataflow_id"); } }
        public static string format_time_interval { get { return GetString("format_time_interval"); } }
        public static string format_time_interval_end { get { return GetString("format_time_interval_end"); } }
        public static string format_time_interval_start { get { return GetString("format_time_interval_start"); } }
        public static string help_excel_csv_layout { get { return GetString("help_excel_csv_layout"); } }
        public static string help_excel_csv_tabular { get { return GetString("help_excel_csv_tabular"); } }
        public static string help_excel_html { get { return GetString("help_excel_html"); } }
        public static string help_excel_separator { get { return GetString("help_excel_separator"); } }
        public static string help_pdf_select_orientation { get { return GetString("help_pdf_select_orientation"); } }
        public static string help_pdf_select_page_size { get { return GetString("help_pdf_select_page_size"); } }
        public static string help_sdmxml_dataset { get { return GetString("help_sdmxml_dataset"); } }
        public static string help_sdmxml_structure { get { return GetString("help_sdmxml_structure"); } }
        public static string help_sdmxml_zip { get { return GetString("help_sdmxml_zip"); } }
        public static string html_criteria_help_1 { get { return GetString("html_criteria_help_1"); } }
        public static string html_criteria_help_2 { get { return GetString("html_criteria_help_2"); } }
        public static string html_criteria_help_codes { get { return GetString("html_criteria_help_codes"); } }
        public static string html_criteria_help_simple { get { return GetString("html_criteria_help_simple"); } }
        public static string html_criteria_help_single_code { get { return GetString("html_criteria_help_single_code"); } }
        public static string html_criteria_help_time { get { return GetString("html_criteria_help_time"); } }
        public static string html_criteria_select_dataflow { get { return GetString("html_criteria_select_dataflow"); } }
        public static string html_criteria_splitter { get { return GetString("html_criteria_splitter"); } }
        public static string html_dataflows_help { get { return GetString("html_dataflows_help"); } }
        public static string html_results_help_1 { get { return GetString("html_results_help_1"); } }
        public static string html_results_help_2 { get { return GetString("html_results_help_2"); } }
        public static string html_results_wait { get { return GetString("html_results_wait"); } }
        public static string label_apply { get { return GetString("label_apply"); } }
        public static string label_axis_x { get { return GetString("label_axis_x"); } }
        public static string label_axis_y { get { return GetString("label_axis_y"); } }
        public static string label_axis_z { get { return GetString("label_axis_z"); } }
        public static string label_cancel { get { return GetString("label_cancel"); } }
        public static string label_clear { get { return GetString("label_clear"); } }
        public static string label_collapse_all { get { return GetString("label_collapse_all"); } }
        public static string label_count { get { return GetString("label_count"); } }
        public static string label_criteria { get { return GetString("label_criteria"); } }
        public static string label_csv { get { return GetString("label_csv"); } }
        public static string label_delete { get { return GetString("label_delete"); } }
        public static string label_deselect_all { get { return GetString("label_deselect_all"); } }
        public static string label_download { get { return GetString("label_download"); } }
        public static string label_excel_csv_layout { get { return GetString("label_excel_csv_layout"); } }
        public static string label_excel_csv_tabular { get { return GetString("label_excel_csv_tabular"); } }
        public static string label_excel_dialog { get { return GetString("label_excel_dialog"); } }
        public static string label_excel_html { get { return GetString("label_excel_html"); } }
        public static string label_excel_separator { get { return GetString("label_excel_separator"); } }
        public static string label_expand_all { get { return GetString("label_expand_all"); } }
        public static string label_expand_categories { get { return GetString("label_expand_categories"); } }
        public static string label_html { get { return GetString("label_html"); } }
        public static string label_invert_selection { get { return GetString("label_invert_selection"); } }
        public static string label_pdf { get { return GetString("label_pdf"); } }
        public static string label_pdf_dialog { get { return GetString("label_pdf_dialog"); } }
        public static string label_pdf_select_orientation { get { return GetString("label_pdf_select_orientation"); } }
        public static string label_pdf_select_page_size { get { return GetString("label_pdf_select_page_size"); } }
        public static string label_query_clear { get { return GetString("label_query_clear"); } }
        public static string label_query_download { get { return GetString("label_query_download"); } }
        public static string label_remove { get { return GetString("label_remove"); } }
        public static string label_reset_display_mode { get { return GetString("label_reset_display_mode"); } }
        public static string label_save { get { return GetString("label_save"); } }
        public static string label_sdmxml_dataset { get { return GetString("label_sdmxml_dataset"); } }
        public static string label_sdmxml_dialog { get { return GetString("label_sdmxml_dialog"); } }
        public static string label_sdmxml_structure { get { return GetString("label_sdmxml_structure"); } }
        public static string label_sdmxml_zip { get { return GetString("label_sdmxml_zip"); } }
        public static string label_select_all { get { return GetString("label_select_all"); } }
        public static string label_open_all { get { return GetString("label_open_all"); } }
        public static string label_close_all { get { return GetString("label_close_all"); } }
        public static string label_time_end { get { return GetString("label_time_end"); } }
        public static string label_time_start { get { return GetString("label_time_start"); } }
        public static string label_view_results { get { return GetString("label_view_results"); } }
        public static string label_xls { get { return GetString("label_xls"); } }
        public static string label_xml { get { return GetString("label_xml"); } }
        public static string no_results_found { get { return GetString("no_results_found"); } }
        public static string question_criteria_clear { get { return GetString("question_criteria_clear"); } }
        public static string question_criteria_update { get { return GetString("question_criteria_update"); } }
        public static string question_truncate_dataset { get { return GetString("question_truncate_dataset"); } }
        public static string text_dataflows_uncategorized { get { return GetString("text_dataflows_uncategorized"); } }
        public static string text_wait { get { return GetString("text_wait"); } }
        public static string time_period_biannual { get { return GetString("time_period_biannual"); } }
        public static string time_period_monthly { get { return GetString("time_period_monthly"); } }
        public static string time_period_quarterly { get { return GetString("time_period_quarterly"); } }
        public static string time_period_single_biannual { get { return GetString("time_period_single_biannual"); } }
        public static string time_period_single_monthly { get { return GetString("time_period_single_monthly"); } }
        public static string time_period_single_quarterly { get { return GetString("time_period_single_quarterly"); } }
        public static string time_period_single_trianual { get { return GetString("time_period_single_trianual"); } }
        public static string time_period_single_weekly { get { return GetString("time_period_single_weekly"); } }
        public static string time_period_triannual { get { return GetString("time_period_triannual"); } }
        public static string time_period_weekly { get { return GetString("time_period_weekly"); } }
        public static string time_period_year { get { return GetString("time_period_year"); } }
        public static string time_period_yearly { get { return GetString("time_period_yearly"); } }
        public static string footer_home { get { return GetString("footer_home"); } }
        public static string footer_copyright { get { return GetString("footer_copyright"); } }
        public static string footer_contacts { get { return GetString("footer_contacts"); } }
        public static string footer_links { get { return GetString("footer_links"); } }
        public static string footer_W3C { get { return GetString("footer_W3C"); } }
        public static string footer_manual { get { return GetString("footer_manual"); } }
        public static string footer_sitemap { get { return GetString("footer_sitemap"); } }
        public static string footer_settings { get { return GetString("footer_settings"); } }
        public static string footer_help { get { return GetString("footer_help"); } }
        public static string img_logo { get { return GetString("img_logo"); } }
        public static string header_text { get { return GetString("header_text"); } }
        public static string label_fontsize { get { return GetString("label_fontsize"); } }
        public static string label_vaccessible { get { return GetString("label_vaccessible"); } }
        public static string label_login { get { return GetString("label_login"); } }
        public static string label_logout { get { return GetString("label_logout"); } }
        public static string label_language { get { return GetString("label_language"); } }
        public static string label_ENlang { get { return GetString("label_ENlang"); } }
        public static string label_ITlang { get { return GetString("label_ITlang"); } }
        public static string label_CustomFonts { get { return GetString("label_CustomFonts"); } }
        public static string label_CustomScreen { get { return GetString("label_CustomScreen"); } }
        public static string label_CustomFolder { get { return GetString("label_CustomFolder"); } }
        public static string label_CustomColors { get { return GetString("label_CustomColors"); } }
        public static string input_Folder { get { return GetString("input_Folder"); } }
        public static string tag_Description { get { return GetString("tag_Description"); } }
        public static string tag_Keywords { get { return GetString("tag_Keywords"); } }
        public static string label_CustomMainColor { get { return GetString("label_CustomMainColor"); } }
        public static string label_CustomSecondaryColor { get { return GetString("label_CustomSecondaryColor"); } }
        public static string label_CustomFontHFColor { get { return GetString("label_CustomFontHFColor"); } }
        public static string label_CustomBodyColor { get { return GetString("label_CustomBodyColor"); } }
        public static string help_Manual { get { return GetString("help_Manual"); } }
        public static string help_DimAtt { get { return GetString("help_DimAtt"); } }
        public static string help_Data { get { return GetString("help_Data"); } }
        public static string help_WS { get { return GetString("help_WS"); } }
        public static string help_Graphic { get { return GetString("help_Graphic"); } }
        public static string help_SDMX { get { return GetString("help_SDMX"); } }
        public static string form_Name { get { return GetString("form_Name"); } }
        public static string form_Email { get { return GetString("form_Email"); } }
        public static string form_Subject { get { return GetString("form_Subject"); } }
        public static string form_Message { get { return GetString("form_Message"); } }
        public static string form_Send { get { return GetString("form_Send"); } }
        public static string form_Agree { get { return GetString("form_Agree"); } }
        public static string form_Name_tp { get { return GetString("form_Name_tp"); } }
        public static string form_Email_tp { get { return GetString("form_Email_tp"); } }
        public static string form_Subject_tp { get { return GetString("form_Subject_tp"); } }
        public static string form_Message_tp { get { return GetString("form_Message_tp"); } }
        public static string form_Send_tp { get { return GetString("form_Send_tp"); } }
        public static string form_Agree_tp { get { return GetString("form_Agree_tp"); } }
        public static string form_Name_alert { get { return GetString("form_Name_alert"); } }
        public static string form_Email_alert { get { return GetString("form_Email_alert"); } }
        public static string form_Subject_alert { get { return GetString("form_Subject_alert"); } }
        public static string form_Message_alert { get { return GetString("form_Message_alert"); } }
        public static string form_Send_alert { get { return GetString("form_Send_alert"); } }
        public static string form_Agree_alert { get { return GetString("form_Agree_alert"); } }
        public static string contact_Numbers { get { return GetString("contact_Numbers"); } }
        public static string contact_Phone { get { return GetString("contact_Phone"); } }
        public static string contact_Fax { get { return GetString("contact_Fax"); } }
        public static string contact_Details { get { return GetString("contact_Details"); } }
        public static string contact_Address { get { return GetString("contact_Address"); } }
        public static string contact_Email { get { return GetString("contact_Email"); } }
        public static string label_Dashboard { get { return GetString("label_Dashboard"); } }
        public static string dashboard_Profile { get { return GetString("dashboard_Profile"); } }
        public static string dashboard_Queries { get { return GetString("dashboard_Queries"); } }
        public static string dashboard_RegUsers { get { return GetString("dashboard_RegUsers"); } }
        public static string dashboard_Statistics { get { return GetString("dashboard_Statistics"); } }
        public static string dashboard_SetHomePage { get { return GetString("dashboard_SetHomePage"); } }
        public static string dashboard_Template { get { return GetString("dashboard_Template"); } }
        public static string dashboard_menu { get { return GetString("dashboard_menu"); } }
        public static string label_queryList_empty { get { return GetString("label_queryList_empty"); } }
        public static string text_remove_query { get { return GetString("text_remove_query"); } }
        public static string label_open_query { get { return GetString("label_open_query"); } }
        public static string label_remove_query { get { return GetString("label_remove_query"); } }
        public static string label_modify_query { get { return GetString("label_modify_query"); } }
        public static string label_error_data { get { return GetString("label_error_data"); } }
        public static string query_saved { get { return GetString("query_saved"); } }
        public static string dashboard_userList { get { return GetString("dashboard_userList"); } }
        public static string button_userListChange { get { return GetString("button_userListChange"); } }
        public static string button_userListChangePsw { get { return GetString("button_userListChangePsw"); } }
        public static string button_userListRemove { get { return GetString("button_userListRemove"); } }
        public static string text_errorListUser { get { return GetString("text_errorListUser"); } }
        public static string text_emptyList { get { return GetString("text_emptyList"); } }
        public static string text_confirmDelUser { get { return GetString("text_confirmDelUser"); } }
        public static string text_confirmDelTemplate { get { return GetString("text_confirmDelTemplate"); } }
        public static string text_userRemoved { get { return GetString("text_userRemoved"); } }
        public static string text_operationKO { get { return GetString("text_operationKO"); } }
        public static string label_psw { get { return GetString("label_psw"); } }
        public static string label_oldPsw { get { return GetString("label_oldPsw"); } }
        public static string label_confirmPsw { get { return GetString("label_confirmPsw"); } }
        public static string label_sendButton { get { return GetString("label_sendButton"); } }
        public static string text_confirmDelQuery { get { return GetString("text_confirmDelQuery"); } }
        public static string label_registrationSuccess { get { return GetString("label_registrationSuccess"); } }
        public static string label_changePswOk { get { return GetString("label_changePswOk"); } }
        public static string label_changePswKO { get { return GetString("label_changePswKO"); } }
        public static string text_msgCampiObbl { get { return GetString("text_msgCampiObbl"); } }
        public static string text_msglengthPsw { get { return GetString("text_msglengthPsw"); } }
        public static string label_confPsw { get { return GetString("label_confPsw"); } }
        public static string label_errorloadDat { get { return GetString("label_errorloadDat"); } }
        public static string label_utenteNoPres { get { return GetString("label_utenteNoPres"); } }
        public static string text_fieldsChangeUser { get { return GetString("text_fieldsChangeUser"); } }
        public static string label_changeUserOk { get { return GetString("label_changeUserOk"); } }
        public static string label_changeUserKO { get { return GetString("label_changeUserKO"); } }
        public static string label_userName { get { return GetString("label_userName"); } }
        public static string label_userSurname { get { return GetString("label_userSurname"); } }
        public static string label_userSex { get { return GetString("label_userSex"); } }
        public static string label_userAge { get { return GetString("label_userAge"); } }
        public static string label_userResidence { get { return GetString("label_userResidence"); } }
        public static string label_userEduQual { get { return GetString("label_userEduQual"); } }
        public static string label_userProfStatus { get { return GetString("label_userProfStatus"); } }
        public static string label_userEconomicSector { get { return GetString("label_userEconomicSector"); } }
        public static string label_userLang { get { return GetString("label_userLang"); } }
        public static string label_userThemes { get { return GetString("label_userThemes"); } }
        public static string label_userEmail { get { return GetString("label_userEmail"); } }
        public static string label_userPsw { get { return GetString("label_userPsw"); } }
        public static string label_userPrivacy { get { return GetString("label_userPrivacy"); } }
        public static string label_userConfPsw { get { return GetString("label_userConfPsw"); } }
        public static string label_userTreatDat { get { return GetString("label_userTreatDat"); } }
        public static string button_userChange { get { return GetString("button_userChange"); } }
        public static string label_settingsDialogTitle { get { return GetString("label_settingsDialogTitle"); } }
        public static string label_settingsDialogMsg { get { return GetString("label_settingsDialogMsg"); } }
        public static string label_settingsDialogText { get { return GetString("label_settingsDialogText"); } }
        public static string label_loginNew { get { return GetString("label_loginNew"); } }
        public static string label_loginPwd { get { return GetString("label_loginPwd"); } }
        public static string label_loginRegistered { get { return GetString("label_loginRegistered"); } }
        public static string label_loginGenError { get { return GetString("label_loginGenError"); } }
        public static string label_queryDelete { get { return GetString("label_queryDelete"); } }
        public static string dashboard_Profiles { get { return GetString("dashboard_Profiles"); } }
        public static string label_open_chart { get { return GetString("label_open_chart"); } }
        public static string label_loginUser { get { return GetString("label_loginUser"); } }
        public static string label_loginPassword { get { return GetString("label_loginPassword"); } }
        public static string label_pageDesc { get { return GetString("label_pageDesc"); } }
        public static string label_numBackward { get { return GetString("label_numBackward"); } }
        public static string label_numForward { get { return GetString("label_numForward"); } }
        public static string label_linkIO { get { return GetString("label_linkIO"); } }
        public static string label_linkOC { get { return GetString("label_linkOC"); } }
        public static string label_linkAPE { get { return GetString("label_linkAPE"); } }
        public static string label_linkOS { get { return GetString("label_linkOS"); } }
        public static string label_ISTAT { get { return GetString("label_ISTAT"); } }
        public static string label_save_template { get { return GetString("label_save_template"); } }
        public static string label_delete_template { get { return GetString("label_delete_template"); } }
        public static string label_changeSuccess { get { return GetString("label_changeSuccess"); } }
        public static string label_open_criteria { get { return GetString("label_open_criteria"); } }
        public static string label_open_layout { get { return GetString("label_open_layout"); } }
        public static string label_dashAdministration { get { return GetString("label_dashAdministration"); } }
        public static string label_dashManagement { get { return GetString("label_dashManagement"); } }
        public static string label_dashProfiles { get { return GetString("label_dashProfiles"); } }
        public static string label_dashLayout { get { return GetString("label_dashLayout"); } }
        public static string label_dashboardTitle { get { return GetString("label_dashboardTitle"); } }
        public static string label_rowsNumber { get { return GetString("label_rowsNumber"); } }
        public static string label_continue { get { return GetString("label_continue"); } }
        public static string label_nullValue { get { return GetString("label_nullValue"); } }
        public static string label_numericValue { get { return GetString("label_numericValue"); } }
        public static string label_widgetSelection { get { return GetString("label_widgetSelection"); } }
        public static string label_wdgChart { get { return GetString("label_wdgChart"); } }
        public static string label_wdgText { get { return GetString("label_wdgText"); } }
        public static string label_wdgTable { get { return GetString("label_wdgTable"); } }
        public static string label_wdgContent { get { return GetString("label_wdgContent"); } }
        public static string label_wdgConfiguration { get { return GetString("label_wdgConfiguration"); } }
        public static string label_wdgRemove { get { return GetString("label_wdgRemove"); } }
        public static string label_wdgConfirmRemove { get { return GetString("label_wdgConfirmRemove"); } }
        public static string label_rowRemove { get { return GetString("label_rowRemove"); } }
        public static string label_rowConfirmRemove { get { return GetString("label_rowConfirmRemove"); } }
        public static string label_allFieldsInserted { get { return GetString("label_allFieldsInserted"); } }

        public static string label_criteriaFieldsInserted { get { return GetString("label_criteriaFieldsInserted"); } }
        public static string label_layoutFieldsInserted { get { return GetString("label_layoutFieldsInserted"); } }
        public static string label_variationFieldsInserted { get { return GetString("label_variationFieldsInserted"); } }
        public static string label_titleFieldsInserted { get { return GetString("label_allFieldsInserted"); } }

        public static string label_addWidget { get { return GetString("label_addWidget"); } }
        public static string label_out_max_results { get { return GetString("label_out_max_results"); } }
        public static string label_addDashboard { get { return GetString("label_addDashboard"); } }
        public static string label_anotherDashboard { get { return GetString("label_anotherDashboard"); } }
        public static string label_buttonSave { get { return GetString("label_buttonSave"); } }
        public static string label_buttonDelete { get { return GetString("label_buttonDelete"); } }
        public static string label_buttonPreview { get { return GetString("label_buttonPreview"); } }
        public static string label_buttonEdit { get { return GetString("label_buttonEdit"); } }
        public static string label_buttonActive { get { return GetString("label_buttonActive"); } }
        public static string label_delDashBoard { get { return GetString("label_delDashBoard"); } }
        public static string label_sureDelDashBoard { get { return GetString("label_sureDelDashBoard"); } }
        public static string label_title { get { return GetString("label_title"); } }
        public static string label_wbsChoose { get { return GetString("label_wbsChoose"); } }
        public static string label_wbsAdd { get { return GetString("label_wbsAdd"); } }
        public static string label_type { get { return GetString("label_type"); } }
        public static string label_variation { get { return GetString("label_variation"); } }
        public static string label_varValue { get { return GetString("label_varValue"); } }
        public static string label_varTrend { get { return GetString("label_varTrend"); } }
        public static string label_varCyclical { get { return GetString("label_varCyclical"); } }
        public static string insertWebService { get { return GetString("insertWebService"); } }
        public static string webServiceMod { get { return GetString("webServiceMod"); } }
        public static string label_reset_pdw_Ok { get { return GetString("label_reset_pdw_Ok"); } }
        public static string label_reset_pdw_Ko { get { return GetString("label_reset_pdw_Ko"); } }
        public static string label_sender_mail { get { return GetString("label_sender_mail"); } }
        public static string label_text_mail { get { return GetString("label_text_mail"); } }
        public static string label_subject_reset_pdw { get { return GetString("label_subject_reset_pdw"); } }
        public static string label_mailSMTPServer { get { return GetString("label_mailSMTPServer"); } }
        public static string label_insert_mail { get { return GetString("label_insert_mail"); } }
        public static string label_mail { get { return GetString("label_mail"); } }
        public static string log_OK { get { return GetString("log_OK"); } }
        public static string log_KO { get { return GetString("log_KO"); } }
        public static string label_test_query { get { return GetString("label_test_query"); } }
        public static string noRemWebService { get { return GetString("noRemWebService"); } }
        public static string confRemWS { get { return GetString("confRemWS"); } }
        public static string confRemDashBoard { get { return GetString("confRemDashBoard"); } }
        public static string label_msgGenError { get { return GetString("label_msgGenError"); } }
        public static string label_invalidFields { get { return GetString("label_invalidFields"); } }
        public static string label_webService { get { return GetString("label_webService"); } }
        public static string label_endPoint { get { return GetString("label_endPoint"); } }
        public static string label_endpointType { get { return GetString("label_endpointType"); } }
        public static string label_endPointV20 { get { return GetString("label_endPointV20"); } }
        public static string label_id { get { return GetString("label_id"); } }
        public static string label_agency { get { return GetString("label_agency"); } }
        public static string label_version { get { return GetString("label_version"); } }
        public static string dashboard_ManagementTemplate { get { return GetString("dashboard_ManagementTemplate"); } }
        public static string emptylistTemplate { get { return GetString("emptylistTemplate"); } }
        public static string emptylistQuery { get { return GetString("emptylistQuery"); } }
        public static string label_templateDelete { get { return GetString("label_templateDelete"); } }
        public static string text_remove_template { get { return GetString("text_remove_template"); } }
        public static string dashboard_Themes { get { return GetString("dashboard_Themes"); } }
        public static string label_invalidWidgets { get { return GetString("label_invalidWidgets"); } }
        public static string label_tree_display { get { return GetString("label_tree_display"); } }
        public static string label_tree_display_request { get { return GetString("label_tree_display_request"); } }
        public static string label_more_web_services { get { return GetString("label_more_web_services"); } }
        public static string dataset_request_filters { get { return GetString("dataset_request_filters"); } }
        public static string dataset_request_layout { get { return GetString("dataset_request_layout"); } }
        public static string dataset_request_data { get { return GetString("dataset_request_data"); } }
        public static string label_addWebService { get { return GetString("label_addWebService"); } }
        public static string label_new_WS { get { return GetString("label_new_WS"); } }
        public static string query_savError { get { return GetString("query_savError"); } }
        public static string label_checkLayout { get { return GetString("label_checkLayout"); } }
        public static string label_fixed_data { get { return GetString("label_fixed_data"); } } 
        public static string label_axe_hor { get { return GetString("label_axe_hor"); } }
        public static string label_axe_ver { get { return GetString("label_axe_ver"); } }
        public static string label_data_grid { get { return GetString("label_data_grid"); } } 
        public static string label_obs_value_desc { get { return GetString("label_obs_value_desc"); } }
        public static string label_dimoutlimit_desc { get { return GetString("label_dimoutlimit_desc"); } }          
        public static string label_check_chart_type_desc { get { return GetString("label_check_chart_type_desc"); } }
        public static string label_check_obs_desc { get { return GetString("label_check_obs_desc"); } }
        public static string label_chart_type_desc { get { return GetString("label_chart_type_desc"); } }
         public static string label_titleWS { get { return GetString("label_titleWS"); } }
        public static string label_endPointWS { get { return GetString("label_endPointWS"); } }
        public static string label_endPointV20WS { get { return GetString("label_endPointV20WS"); } }
        public static string label_endPointTypeWS { get { return GetString("label_endPointTypeWS"); } }
        public static string label_localeWS { get { return GetString("label_localeWS"); } }
       
        public static string label_enableHttpWS { get { return GetString("label_enableHttpWS"); } }
        public static string label_domainWS { get { return GetString("label_domainWS"); } }
        public static string label_UsernameWS { get { return GetString("label_UsernameWS"); } }
        public static string label_PasswordWS { get { return GetString("label_PasswordWS"); } }
        public static string label_enablePoxyWS { get { return GetString("label_enablePoxyWS"); } }
        public static string label_useSystemProxyWS { get { return GetString("label_useSystemProxyWS"); } }
        public static string label_proxyServerWS { get { return GetString("label_proxyServerWS"); } }
        public static string label_proxyServerPortWS { get { return GetString("label_proxyServerPortWS"); } }
        public static string label_proxyUsernameWS { get { return GetString("label_proxyUsernameWS"); } }
        public static string label_proxyPasswordWS { get { return GetString("label_proxyPasswordWS"); } }
        public static string button_showTree { get { return GetString("button_showTree"); } }
        public static string button_openTree { get { return GetString("button_openTree"); } }
        public static string no_result_found { get { return GetString("no_result_found"); } }
        public static string messageWorkProg { get { return GetString("messageWorkProg"); } }
        public static string label_time_plus { get { return GetString("label_time_plus"); } }

        public static string label_error_dash_save { get { return GetString("label_error_dash_save"); } }
        public static string label_removeWidget { get { return GetString("label_removeWidget"); } }
        public static string label_removeRow { get { return GetString("label_removeRow"); } }
        public static string label_addRow { get { return GetString("label_addRow"); } }
        public static string label_configureWidget { get { return GetString("label_configureWidget"); } }
        public static string label_errorDeleteRow { get { return GetString("label_errorDeleteRow"); } }
        public static string label_buttonDefault { get { return GetString("label_buttonDefault"); } }
        public static string label_varSerie { get { return GetString("label_varSerie"); } }
        public static string label_TIME_PERIOD { get { return GetString("label_TIME_PERIOD"); } }
        public static string label_serie_label { get { return GetString("label_serie_label"); } }
        public static string label_dimension_axe { get { return GetString("label_dimension_axe"); } }
        public static string label_view_uncategorised { get { return GetString("label_view_uncategorised"); } }
        public static string label_save_csv_tabular { get { return GetString("label_save_csv_tabular"); } }
        public static string label_save_csv_not_formatted { get { return GetString("label_save_csv_not_formatted"); } }
        public static string label_save_xls { get { return GetString("label_save_xls"); } }
        public static string label_save_pdf { get { return GetString("label_save_pdf"); } }
        public static string label_save_html { get { return GetString("label_save_html"); } }
        public static string label_save_sdmx_data { get { return GetString("label_save_sdmx_data"); } }
        public static string label_save_sdmx_query { get { return GetString("label_save_sdmx_query"); } }
        public static string label_desc_save_csv_tabular { get { return GetString("label_desc_save_csv_tabular"); } }
        public static string label_desc_save_csv_not_formatted { get { return GetString("label_desc_save_csv_not_formatted"); } }
        public static string label_desc_save_xls { get { return GetString("label_desc_save_xls"); } }
        public static string label_desc_save_pdf { get { return GetString("label_desc_save_pdf"); } }
        public static string label_desc_save_html { get { return GetString("label_desc_save_html"); } }
        public static string label_desc_save_sdmx_data { get { return GetString("label_desc_save_sdmx_data"); } }
        public static string label_desc_save_sdmx_query { get { return GetString("label_desc_save_sdmx_query"); } }
        public static string label_select_download { get { return GetString("label_select_download"); } }
        public static string label_landscape { get { return GetString("label_landscape"); } }
        public static string label_separator { get { return GetString("label_separator"); } }
        public static string label_with_quote { get { return GetString("label_with_quote"); } }
        public static string label_separator_outlimit { get { return GetString("label_separator_outlimit"); } }
        public static string label_save_sdmx_structure { get { return GetString("label_save_sdmx_structure"); } }
        public static string label_dest_save_sdmx_structure { get { return GetString("label_dest_save_sdmx_structure"); } }
        public static string label_close { get { return GetString("label_close"); } }
        public static string label_separator_decimal { get { return GetString("label_separator_decimal"); } }
        public static string label_select_df { get { return GetString("label_select_df"); } }
        public static string label_layout_x_missing { get { return GetString("label_layout_x_missing"); } }
        public static string label_layout_y_missing { get { return GetString("label_layout_y_missing"); } }
        public static string label_endPointSourceWS { get { return GetString("label_endPointSourceWS"); } }                         
                                 
        public static string label_useVirtualDF { get { return GetString("label_useVirtualDF"); } }
        public static string label_useUncategorysed { get { return GetString("label_useUncategorysed"); } }

        public static string label_description { get { return GetString("label_description"); } }
        public static string label_error_network { get { return GetString("label_error_network"); } }
        public static string label_idWS { get { return GetString("label_idWS"); } }
            
                                  
        private static Dictionary<CultureInfo, List<DictionaryEntry>> AllMessages = null;
        private static string GetString(string Key)
        {
             CultureInfo ci;

            if (AllMessages == null)
                LoadXmlMessages();
            var appo = new CultureInfo(DefaultCulture.TwoLetterISOLanguageName);

            ci = AllMessages.ContainsKey(DefaultCulture) ? DefaultCulture : (AllMessages.ContainsKey(new CultureInfo(DefaultCulture.TwoLetterISOLanguageName)) ? new CultureInfo(DefaultCulture.TwoLetterISOLanguageName) : null);

            if (ci == null)
                return null;

            //if (!AllMessages.ContainsKey(DefaultCulture) && !AllMessages.ContainsKey(new CultureInfo(DefaultCulture.TwoLetterISOLanguageName)))
            //    return null;
            DictionaryEntry mess = AllMessages[ci].Find(m => m.Key.ToString() == Key);
            return mess.Value == null ? null : mess.Value.ToString();

        }

        private static void LoadXmlMessages()
        {
            try
            {
                AllMessages = new Dictionary<CultureInfo, List<DictionaryEntry>>();
                string path = System.Web.Hosting.HostingEnvironment.MapPath("~/bin/App_GlobalResources/");

                if(path == null)
                    path = AppDomain.CurrentDomain.BaseDirectory + @"App_GlobalResources\";

                string[] listFileResource = Directory.GetFiles(path, "GlobalResources_*.xml");
                XmlDocument doc = new XmlDocument();

                foreach (string fileName in listFileResource)
                {
                    doc.Load(fileName);

                    string locale = Path.GetFileNameWithoutExtension(fileName).Replace("GlobalResources_", "");

                    CultureInfo cult = GetLocale(locale);
                    if (cult == null)
                        continue;
                    if (!AllMessages.ContainsKey(cult))
                        AllMessages[cult] = new List<DictionaryEntry>();


                if (doc.ChildNodes.Count == 0)
                    return;
                foreach (XmlNode Res in doc.ChildNodes[0].ChildNodes)
                {
                    if (Res.Name == "Resource" && Res.Attributes["key"] != null)
                    {
                        string Reskey = Res.Attributes["key"].Value;
                        foreach (XmlNode Names in Res.ChildNodes)
                        {
                            if (Names.Name == "Name")
                            {

                                AllMessages[cult].Add(new DictionaryEntry(Reskey, Names.InnerText));
                            }
                        }
                    }
                }
            }
            }
            catch (Exception)
            {

                AllMessages = null;
            }
        }

        private static void LoadXmlMessagesOneFile()
        {
            try
            {
                AllMessages = new Dictionary<CultureInfo, List<DictionaryEntry>>();
                string path = System.Web.Hosting.HostingEnvironment.MapPath("~/bin/App_GlobalResources/GlobalResources.xml");

                if (path == null)
                    path = AppDomain.CurrentDomain.BaseDirectory + @"App_GlobalResources\GlobalResources.xml";

                XmlDocument doc = new XmlDocument();
                doc.Load(path);
                if (doc.ChildNodes.Count == 0)
                    return;
                foreach (XmlNode Res in doc.ChildNodes[0].ChildNodes)
                {
                    if (Res.Name == "Resource" && Res.Attributes["key"] != null)
                    {
                        string Reskey = Res.Attributes["key"].Value;
                        foreach (XmlNode Names in Res.ChildNodes)
                        {
                            if (Names.Name == "Name" && Names.Attributes["LocaleIsoCode"] != null)
                            {
                                CultureInfo cult = GetLocale(Names.Attributes["LocaleIsoCode"].Value);
                                if (cult == null)
                                    continue;

                                if (!AllMessages.ContainsKey(cult))
                                    AllMessages[cult] = new List<DictionaryEntry>();

                                AllMessages[cult].Add(new DictionaryEntry(Reskey, Names.InnerText));
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {

                AllMessages = null;
            }
        }


        private static CultureInfo DefaultCulture = CultureInfo.CurrentUICulture;

        public static CultureInfo GetLocale(string locale)
        {
            if (locale == null)
                return null;
            return CultureInfo.GetCultureInfo(locale);
        }
        public static CultureInfo SetLocale(string locale)
        {
            CultureInfo locaSet = GetLocale(locale);
            if (locaSet != null)
            {
                DefaultCulture = locaSet;
            }
            return locaSet;
        }

        public static List<DictionaryEntry> GetResourceSet(CultureInfo culture)
        {
            if (AllMessages == null)
                LoadXmlMessages();
            if (AllMessages.ContainsKey(culture))
                return AllMessages[culture];
            return AllMessages.First().Value;
        }

        public static ICollection<CultureInfo> AvailableLocales()
        {
            if (AllMessages == null)
                LoadXmlMessages();
            ICollection<CultureInfo> allCulture = new List<CultureInfo>();
            foreach (CultureInfo item in AllMessages.Keys)
                allCulture.Add(item);
            return allCulture;
        }
    }
}
