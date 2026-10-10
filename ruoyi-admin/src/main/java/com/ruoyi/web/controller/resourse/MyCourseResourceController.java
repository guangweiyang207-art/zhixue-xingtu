package com.ruoyi.web.controller.resourse;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.business.domain.MyCourseResource;
import com.ruoyi.business.service.IMyCourseResourceService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 资源模块Controller
 * 
 * @author llhl
 * @date 2026-06-02
 */
@RestController
@RequestMapping("/business/resource")
public class MyCourseResourceController extends BaseController
{
    @Autowired
    private IMyCourseResourceService myCourseResourceService;

    /**
     * 查询资源模块列表
     */
    @PreAuthorize("@ss.hasPermi('business:resource:list')")
    @GetMapping("/list")
    public TableDataInfo list(MyCourseResource myCourseResource)
    {
        startPage();
        List<MyCourseResource> list = myCourseResourceService.selectMyCourseResourceList(myCourseResource);
        return getDataTable(list);
    }

    /**
     * 导出资源模块列表
     */
    @PreAuthorize("@ss.hasPermi('business:resource:export')")
    @Log(title = "资源模块", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MyCourseResource myCourseResource)
    {
        List<MyCourseResource> list = myCourseResourceService.selectMyCourseResourceList(myCourseResource);
        ExcelUtil<MyCourseResource> util = new ExcelUtil<MyCourseResource>(MyCourseResource.class);
        util.exportExcel(response, list, "资源模块数据");
    }

    /**
     * 获取资源模块详细信息
     */
    @PreAuthorize("@ss.hasPermi('business:resource:query')")
    @GetMapping(value = "/{reId}")
    public AjaxResult getInfo(@PathVariable("reId") Long reId)
    {
        return success(myCourseResourceService.selectMyCourseResourceByReId(reId));
    }

    /**
     * 新增资源模块
     */
    @PreAuthorize("@ss.hasPermi('business:resource:add')")
    @Log(title = "资源模块", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MyCourseResource myCourseResource)
    {
        return toAjax(myCourseResourceService.insertMyCourseResource(myCourseResource));
    }

    /**
     * 修改资源模块
     */
    @PreAuthorize("@ss.hasPermi('business:resource:edit')")
    @Log(title = "资源模块", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MyCourseResource myCourseResource)
    {
        return toAjax(myCourseResourceService.updateMyCourseResource(myCourseResource));
    }

    /**
     * 删除资源模块
     */
    @PreAuthorize("@ss.hasPermi('business:resource:remove')")
    @Log(title = "资源模块", businessType = BusinessType.DELETE)
	@DeleteMapping("/{reIds}")
    public AjaxResult remove(@PathVariable Long[] reIds)
    {
        return toAjax(myCourseResourceService.deleteMyCourseResourceByReIds(reIds));
    }
}
