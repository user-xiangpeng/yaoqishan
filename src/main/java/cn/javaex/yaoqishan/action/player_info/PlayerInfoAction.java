package cn.javaex.yaoqishan.action.player_info;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.player_info.PlayerInfoService;
import cn.javaex.yaoqishan.view.PlayerInfo;
import cn.javaex.yaoqishan.view.Result;

@Controller
@RequestMapping("player_info")
public class PlayerInfoAction {

	@Autowired
	private PlayerInfoService playerInfoService;
	
	/**
	 * 查询所有播放器
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map) {
		
		List<PlayerInfo> list = playerInfoService.list();
		map.put("list", list);
		
		return "admin/player_info/list";
	}
	
	/**
	 * 播放器编辑
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			@RequestParam(value="id") String id) {
		
		PlayerInfo playerInfo = playerInfoService.selectById(id);
		map.put("playerInfo", playerInfo);

		map.put("id", id);

		return "admin/player_info/edit";
	}
	
	/**
	 * 保存播放器
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(PlayerInfo playerInfo) {
		
		playerInfoService.save(playerInfo);
		return Result.success();
	}
	
	/**
	 * 批量保存播放器设置
	 * @param idArr 播放器主键数组
	 * @param sortArr 播放器排序数组
	 * @param nameArr 播放器名称数组
	 */
	@RequestMapping("batch_save.json")
	@ResponseBody
	public Result batchSave(
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr) {
		
		List<PlayerInfo> playerInfoList = new ArrayList<PlayerInfo>();
		
		// 判断是否已有既存数据
		if (idArr.length==0) {
			// 全是新增
			// 遍历sortArr数组
			for (int i=0; i<sortArr.length; i++) {
				PlayerInfo playerInfo = new PlayerInfo();
				playerInfo.setSort(sortArr[i]);
				playerInfo.setName(nameArr[i]);
				
				playerInfoList.add(playerInfo);
			}
		} else {
			// 遍历idArr数组
			for (int i=0; i<idArr.length; i++) {
				PlayerInfo playerInfo = new PlayerInfo();
				playerInfo.setId(idArr[i]);
				playerInfo.setSort(sortArr[i]);
				playerInfo.setName(nameArr[i]);
				
				playerInfoList.add(playerInfo);
			}
		}
		
		
		playerInfoService.batchSave(playerInfoList);

		return Result.success();
	}
	
	/**
	 * 删除
	 * @param idArr 播放器主键数组
	 * @throws QingException 
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(
			@RequestParam(value="idArr") String[] idArr) throws QingException {
		
		playerInfoService.delete(idArr);
		return Result.success();
	}
}
