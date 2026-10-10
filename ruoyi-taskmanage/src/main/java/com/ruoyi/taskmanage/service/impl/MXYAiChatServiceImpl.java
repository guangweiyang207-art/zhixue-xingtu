package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.taskmanage.domain.AiChat;
import com.ruoyi.taskmanage.mapper.MXYAiChatMapper;
import com.ruoyi.taskmanage.service.IMXYAiChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MXYAiChatServiceImpl implements IMXYAiChatService {

    @Autowired private MXYAiChatMapper mapper;

    @Override public List<AiChat> selectAiChatList(AiChat a) { return mapper.selectAiChatList(a); }
    @Override public AiChat selectAiChatById(Long chatId) { return mapper.selectAiChatById(chatId); }
    @Override public long countUnanswered() { return mapper.countUnanswered(); }
    @Override public int insertAiChat(AiChat a) { return mapper.insertAiChat(a); }
    @Override public int updateAiChat(AiChat a) { return mapper.updateAiChat(a); }
    @Override public int deleteAiChatById(Long chatId) { return mapper.deleteAiChatById(chatId); }
}
