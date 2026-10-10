package com.ruoyi.study.mapper;

import java.util.List;
import com.ruoyi.study.domain.MyAiChat;

public interface MyAiChatMapper 
{
    public MyAiChat selectMyAiChatByChatId(Long chatId);
    public List<MyAiChat> selectMyAiChatList(MyAiChat myAiChat);
    public int insertMyAiChat(MyAiChat myAiChat);
    public int updateMyAiChat(MyAiChat myAiChat);
    public int deleteMyAiChatByChatId(Long chatId);
    public int deleteMyAiChatByChatIds(Long[] chatIds);
}
