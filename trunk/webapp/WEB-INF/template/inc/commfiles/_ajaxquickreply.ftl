﻿<#-- 
	描述：AJAX快速回复模板 
	作者：黄磊 
	版本：v1.0 
-->
<#if quickeditorad!="">
<div class="leaderboard">${quickeditorad}</div>
</#if>
<script type="text/javascript" src="javascript/bbcode.js"></script>
<script type="text/javascript" src="javascript/post.js"></script>
<form method="post" name="postform" id="postform" action="postreply.action?topicid=${topicid}" enctype="multipart/form-data" onsubmit="return validate(this);" >
<div id="quickpost" class="box">
	<h4>快速回复帖子</h4>
	<div class="postoptions">
		<h5>选项</h5>
		<p><label><input type="checkbox" name="parseurloff" id="parseurloff" value="1" <#if parseurloff==1> checked </#if>/> 禁用</label> URL 识别</p>
		<p><label><input type="checkbox" name="smileyoff" id="smileyoff" value="1" <#if smileyoff==1> checked disabled </#if>/> 禁用 </label>表情</p>
		<p><label><input type="checkbox" name="bbcodeoff" id="bbcodeoff" value="1" <#if bbcodeoff==1> checked disabled </#if>/> 禁用 </label>LForum代码</p>
		<p><label><input type="checkbox" name="usesig" id="usesig" value="1" <#if usesig==1> checked </#if>/> 使用个人签名</label></p>
		<p><label><input type="checkbox" name="emailnotify" id="emailnotify" /> 发送邮件通知楼主</label></p>
	</div>
	<div class="postform">
		<h5><label for="subject">标题</label>							
			<#if isenddebate==false && topic.special==4>
				<select name="debateopinion" id="debateopinion">
					<option value="0" selected></option>
					<option value="1">正方</option>
					<option value="2">反方</option>
				</select>
			</#if>
			<input type="text" id="title" name="title" size="84" tabindex="1" value="" class="colorblue" onfocus="this.className='colorfocus';" onblur="this.className='colorblue';" /><input type="hidden" id="postid" name="postid" value="-1" />
		</h5>
		<p><label>内容</label>
		<textarea name="message" cols="80" rows="7" class="autosave" style="background:url(${quickbgadimg}) no-repeat 0 0; " <#if quickbgadlink!=""> onfocus="$('adlinkbtn').style.display='';$('closebtn').style.display='';this.onfocus=null;"</#if> id="message" tabindex="2" onkeydown="ajaxctlent(event, this.form, ${topicid}, isendpage, '${templatepath}');"></textarea>
		<#if isseccode><p class="formcode">验证码:<#include "_vcode.ftl"/></p></#if></td>
		<script type="text/javascript">
			var isendpage = (${pageid}==${pagecount});
			var textobj = $('message');
			var lang = new Array();
			if(is_ie >= 5 || is_moz >= 2) {
				window.onbeforeunload = function () {
					saveData(textobj.value);
				};
				lang['post_autosave_none'] = "没有可以恢复的数据";
				lang['post_autosave_confirm'] = "本操作将覆盖当前帖子内容，确定要恢复数据吗？";
			}
			else {
				$('restoredata').style.display = 'none';
			}
			var bbinsert = parseInt('1');
			var smileyinsert = parseInt('1');
			var editor_id = 'posteditor';
			var smiliesCount = 9;
			var colCount = 3;
			var showsmiliestitle = 0;
			var smiliesIsCreate = 0;	
			var scrMaxLeft; //表情滚动条宽度
			var smilies_HASH = {};
			</script>
		</p>
		<p class="btns">
			<a href="###" id="closebtn" style="display:none;" onclick="$('message').style.background='';this.style.display='none';$('adlinkbtn').style.display='none';">关闭广告</a>
			<a href="${quickbgadlink}" id="adlinkbtn" style="display:none;" target="_blank" onclick="">进入广告</a>
			<button type="submit" id="postsubmit" name="replysubmit" value="发表帖子" tabindex="3">发表帖子</button>[可按Ctrl+Enter发布]&nbsp;
			<input name="topicsreset" value="清空内容" tabindex="6" type="reset" onclick="javascript:document.postform.reset(); return true; "/>&nbsp;<input name="restoredata" id="restoredata" value="恢复数据" tabindex="5" title="恢复上次自动保存的数据" onclick="loadData();" type="button" />
		</p>
	</div>
	<div class="smilies">
<#if Issmileyinsert==1>
	<#assign defaulttypname=""/>
	<div class="navcontrol">
		<div class="smiliepanel">
			<div id="scrollbar" class="scrollbar">
					<table cellspacing="0" cellpadding="0" border="0">
						<tr>
						<#list smilietypes as stype>
							<#if stype.id==1>
							<#assign defaulttypname=stype.code/>
							</#if>
							<td id="t_s_${stype.id}"><div id="s_${stype.id}" onclick="showsmiles(${stype.id}, '${stype.code}');" <#if stype.id!=1>style="display:none;"<#else>class="lian"</#if>>${stype.code}</div></td>
						</#list>
						</tr>
					</table>
			</div>
			<div id="scrlcontrol">
				<img src="editor/images/smilie_prev_default.gif" alt="向前" onmouseover="if($('scrollbar').scrollLeft>0)this.src=this.src.replace(/_default|_selected/, '_hover');" onmouseout="this.src=this.src.replace(/_hover|_selected/, '_default');" onmousedown="if($('scrollbar').scrollLeft>0){this.src=this.src.replace(/_hover|_default/, '_selected');this.boder=1;}" onmouseup="if($('scrollbar').scrollLeft>0)this.src=this.src.replace(/_selected/, '_hover');else{this.src=this.src.replace(/_selected|_hover/, '_default');}this.border=0;" onclick="scrollSmilieTypeBar($('scrollbar'), 1-$('t_s_1').clientWidth);"/>&nbsp;
				<img src="editor/images/smilie_next_default.gif" alt="向后"  onmouseover="if($('scrollbar').scrollLeft<scrMaxLeft)this.src=this.src.replace(/_default|_selected/, '_hover');" onmouseout="this.src=this.src.replace(/_hover|_selected/, '_default');" onmousedown="if($('scrollbar').scrollLeft<scrMaxLeft){this.src=this.src.replace(/_hover|_default/, '_selected');this.boder=1;}" onmouseup="if($('scrollbar').scrollLeft<scrMaxLeft)this.src=this.src.replace(/_selected/, '_hover');else{this.src=this.src.replace(/_selected|_hover/, '_default');}this.border=0;" onclick="scrollSmilieTypeBar($('scrollbar'), $('t_s_1').clientWidth);" />
			</div>	
		</div>
		<div  id="showsmilie"><img src="images/common/loading_wide.gif" width="90%" alt="表情加载"/><p>正在加载表情...</p></div>
		<div id="showsmilie_pagenum"></div></div>
	<script type="text/javascript">	
		var firstpagesmilies_json ={ ${firstpagesmilies} };
		showFirstPageSmilies(firstpagesmilies_json, '${defaulttypname}', 12);
		function getSmilies(func){
			var c="tools/ajax.action?t=smilies";
			_sendRequest(c,function(d){var e={};try{e=eval("("+d+")")}catch(f){e={}}var h=e?e:null;func(h);e=null;func=null},false,true);
		}
		getSmilies(function(obj){ 
		smilies_HASH = obj; 
		showsmiles(1, '${defaulttypname}');
		});
		window.onload = function() {
			
			$('scrollbar').scrollLeft = 10000;
			scrMaxLeft = $('scrollbar').scrollLeft;
			$('scrollbar').scrollLeft = 1;	
			if ($('scrollbar').scrollLeft > 0)
			{
				$('scrlcontrol').style.display = '';
				$('scrollbar').scrollLeft = 0;	
			}
		}
	</script>
 </#if>
	</div>
</div>
<script type="text/javascript" src="javascript/template_quickreply.js"></script>
</form>