<#-- 
	描述：随机验证码模板 
	作者：黄磊 
	版本：v1.0 
-->
<!-- onkeydown="return (event.keyCode ? event.keyCode : event.which ? event.which : event.charCode) != 13"-->
<input size="10"  style="width:50px;" class="colorblue" onfocus="this.className='colorfocus';" onblur="this.className='colorblue';" onkeyup="changevcode(this.form, this.value);" />
&nbsp;
<img src="tools/verifyImagePage.action?time=${reqcfg.pageTime}" class="cursor" id="vcodeimg" onclick="this.src='tools/verifyImagePage.action?id=${olid}&time=' + Math.random();" />
<input name="reloadvcade" type="button" class="colorblue" id="reloadvcade" value="刷新验证码"  onclick="document.getElementById('vcodeimg').src='tools/verifyImagePage.action?time=' + Math.random();" tabindex="-1"  style="color:#99cc00; width:75px;" />
<script type="text/javascript">
	$('vcodeimg').src='tools/verifyImagePage.action?bgcolor=F5FAFE&time=' + Math.random();
	//document.getElementById('vcode').value = "";
	function changevcode(form, value)
	{
		if (!$('vcode'))
		{
			var vcode = document.createElement('input');
			vcode.id = 'vcode';
			vcode.name = 'vcode';
			vcode.type = 'hidden';
			vcode.value = value;
			form.appendChild(vcode);
		}
		else
		{
			$('vcode').value = value;
		}
	}
</script>

