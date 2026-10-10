package com.ruoyi.study.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.study.mapper.MyAiChatMapper;
import com.ruoyi.study.domain.MyAiChat;
import com.ruoyi.study.service.IMyAiChatService;

@Service
public class MyAiChatServiceImpl implements IMyAiChatService
{
    @Autowired
    private MyAiChatMapper myAiChatMapper;

    @Override
    public MyAiChat selectMyAiChatByChatId(Long chatId)
    {
        return myAiChatMapper.selectMyAiChatByChatId(chatId);
    }

    @Override
    public List<MyAiChat> selectMyAiChatList(MyAiChat myAiChat)
    {
        return myAiChatMapper.selectMyAiChatList(myAiChat);
    }

    @Override
    public int insertMyAiChat(MyAiChat myAiChat)
    {
        return myAiChatMapper.insertMyAiChat(myAiChat);
    }

    @Override
    public int updateMyAiChat(MyAiChat myAiChat)
    {
        return myAiChatMapper.updateMyAiChat(myAiChat);
    }

    @Override
    public int deleteMyAiChatByChatIds(Long[] chatIds)
    {
        return myAiChatMapper.deleteMyAiChatByChatIds(chatIds);
    }

    @Override
    public int deleteMyAiChatByChatId(Long chatId)
    {
        return myAiChatMapper.deleteMyAiChatByChatId(chatId);
    }
}
