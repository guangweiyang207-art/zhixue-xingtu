package com.ruoyi.study.service;

import java.util.List;
import com.ruoyi.study.domain.MyAiChat;

public interface IMyAiChatService 
{
    public MyAiChat selectMyAiChatByChatId(Long chatId);
    public List<MyAiChat> selectMyAiChatList(MyAiChat myAiChat);
    public int insertMyAiChat(MyAiChat myAiChat);
    public int updateMyAiChat(MyAiChat myAiChat);
    public int deleteMyAiChatByChatIds(Long[] chatIds);
    public int deleteMyAiChatByChatId(Long chatId);
}
