function show_waiting_bar(){
    $("#waiting_bar").modal("show")
}
function get_batch (obj){
    id = $(obj).val()
    // alert("Yalla Habibi" + id)
    window.top.location.href = "/"+id

}