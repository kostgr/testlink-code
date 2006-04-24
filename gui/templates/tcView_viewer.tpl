{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
$Id: tcView_viewer.tpl,v 1.2 2006/04/24 10:36:24 franciscom Exp $
viewer for test case in test specification

20060325 - franciscom - 
*}

{if $show_title == "yes"}
<h1>{lang_get s='title_test_case'} {$my_testcase.name|escape} </h1>
{/if}

{if $can_edit == "yes" }
	{* 
	  {include file="inc_update.tpl" result=$sqlResult action=$action item="test case" refresh="yes"}
	*}
  
	<div class="groupBtn">
	<form method="post" action="lib/testcases/tcEdit.php">
	  <input type="hidden" name="testcase_id" value="{$my_testcase.testcase_id}">
	  <input type="hidden" name="tcversion_id" value="{$my_testcase.id}">

    
    {if $status_quo eq null or $status_quo[$my_testcase.id].executed eq null}
 	    <input type="submit" id="edit_tc"   name="edit_tc"   value="{lang_get s='btn_edit'}">
    {/if}

		{if $can_delete_testcase == "yes" }
			<input type="submit" id="delete_tc" name="delete_tc" value="{lang_get s='btn_del'}">
    {/if}

    {if $can_delete_version == "yes" }
				<input type="submit" id="delete_tc_version" 
				                     name="delete_tc_version" value="{lang_get s='btn_del_this_version'}">
    {/if}
    
    {if $can_move_copy == "yes" }
    		<input type="submit" id="move_copy_tc" 
    		                     name="move_copy_tc"   value="{lang_get s='btn_mv_cp'}">
    {/if}		                     
		<input type="submit" id="do_create_new_version" name="do_create_new_version"   value="{lang_get s='btn_new_version'}">

	</form>
	</div>	
{/if}

	<table width="95%" class="simple" border="0">

    {if $show_title == "yes"}
		<tr>
			<th  colspan="2">{lang_get s='th_test_case_id'}{$my_testcase.testcase_id} :: 
			{lang_get s='title_test_case'} {$my_testcase.name|escape}</th>
		</tr>
    {/if} 
    
    {if $show_version == "yes"}
		<tr>
			<td class="bold" colspan="2">{lang_get s='version'} 
			{$my_testcase.version|escape}</td>
		</tr>
		{/if}
		
		<tr >
			<td class="bold" colspan="2">{lang_get s='summary'}</td>
		</tr>
		<tr>
			<td  colspan="2">{$my_testcase.summary}</td>
		</tr>
		<tr>
			<td class="bold" width="50%">{lang_get s='steps'}</td>
			<td class="bold" width="50%">{lang_get s='expected_results'}</td>
		</tr>
		<tr>
			<td>{$my_testcase.steps}</td>
			<td>{$my_testcase.expected_results}</td>
		</tr>
		<tr>
		
		<td  colspan="2">
		<table>
	    <tr>
	  	<td width="35%"><a href="lib/keywords/keywordsView.php" 
				target="mainframe" class="bold">{lang_get s='keywords'}</a>: &nbsp;
			</td>
			<td>
				{* 20060423 - franciscom *}
		  	{foreach item=keyword_item from=$keywords_map}
				    {$keyword_item|escape}
				    <br>
				{/foreach}
			</td>
			</tr>
		</table>	
		</td>
		</tr>
		
	{if $opt_requirements == TRUE && $view_req_rights == "yes"}
		<tr>
			<td colspan="2"><span><a href="lib/req/reqSpecList.php" 
				target="mainframe" class="bold">{lang_get s='Requirements'}</a>
				: &nbsp;</span>
			
				{section name=item loop=$arrReqs}
					<span onclick="javascript: open_top(fRoot+'lib/req/reqView.php?idReq={$arrReqs[item].id}');"
					style="cursor:  pointer;">
					{$arrReqs[item].title|escape}</span>, 
				{sectionelse}
					{lang_get s='none'}
				{/section}
			</td>
		</tr>
	{/if}
	</table>
	
	<div>
		<p>{lang_get s='title_created'}&nbsp;{localize_timestamp ts=$my_testcase.creation_ts }&nbsp;
			{lang_get s='by'}&nbsp;{$my_testcase.author_first_name|escape}&nbsp;{$my_testcase.author_last_name|escape}
		
		{if $my_testcase.updater_last_name ne "" || $my_testcase.updater_first_name ne ""}
		<br />{lang_get s='title_last_mod'}&nbsp;{localize_timestamp ts=$my_testcase.modification_ts}
		&nbsp;{lang_get s='by'}&nbsp;{$my_testcase.updater_first_name|escape}
		                       &nbsp;{$my_testcase.updater_last_name|escape}
		{/if}
		</p>
	</div>