package com.ruoyi.blog.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.ruoyi.blog.mapper.CmsLabProjectMapper;
import com.ruoyi.blog.service.ICmsLabProjectService;
import com.ruoyi.blog.service.impl.CmsLabProjectServiceImpl;

/**
 * Explicit laboratory service registration for stable DevTools restarts.
 */
@Configuration
public class CmsLabConfiguration
{
    @Bean
    public ICmsLabProjectService cmsLabProjectService(CmsLabProjectMapper mapper)
    {
        return new CmsLabProjectServiceImpl(mapper);
    }
}
